import 'dart:async';
import 'package:flutter/foundation.dart';
import 'api_service.dart';

enum DownloadStatus { pending, downloading, completed, failed }

class DownloadInfo {
  final String id;
  final String url;
  final String? title;
  final String? uploader;
  final String? thumbnail;
  final DownloadStatus status;
  final String? error;
  final DateTime? createdAt;
  final DateTime? completedAt;

  DownloadInfo({
    required this.id,
    required this.url,
    this.title,
    this.uploader,
    this.thumbnail,
    required this.status,
    this.error,
    this.createdAt,
    this.completedAt,
  });

  factory DownloadInfo.fromMap(Map<String, dynamic> map) {
    return DownloadInfo(
      id: map['id'] ?? '',
      url: map['url'] ?? '',
      title: map['title'],
      uploader: map['uploader'],
      thumbnail: map['thumbnail'],
      status: _parseStatus(map['status']),
      error: map['error'],
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : null,
      completedAt: map['completed_at'] != null
          ? DateTime.parse(map['completed_at'])
          : null,
    );
  }

  static DownloadStatus _parseStatus(String? status) {
    switch (status) {
      case 'pending':
        return DownloadStatus.pending;
      case 'downloading':
        return DownloadStatus.downloading;
      case 'completed':
        return DownloadStatus.completed;
      case 'failed':
        return DownloadStatus.failed;
      default:
        return DownloadStatus.pending;
    }
  }
}

class VideoDownloadService extends ChangeNotifier {
  final Map<String, DownloadInfo> _downloads = {};
  Timer? _statusTimer;
  bool _isPolling = false;

  Map<String, DownloadInfo> get downloads => Map.unmodifiable(_downloads);
  bool get isPolling => _isPolling;

  // Start polling for download status updates
  void startPolling() {
    if (_isPolling) return;

    _isPolling = true;
    _statusTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _updateDownloadStatuses();
    });
    notifyListeners();
  }

  // Stop polling
  void stopPolling() {
    _statusTimer?.cancel();
    _statusTimer = null;
    _isPolling = false;
    notifyListeners();
  }

  // Get video information and available formats
  Future<Map<String, dynamic>?> getVideoInfo(String url) async {
    try {
      final info = await ApiService.getVideoInfo(url);
      return info;
    } catch (e) {
      print('Error getting video info: $e');
      return null;
    }
  }

  // Start a new download
  Future<DownloadInfo?> startDownload(String url, {String? formatId}) async {
    try {
      final result = await ApiService.startDownload(url, formatId: formatId);

      if (result != null && result['status'] == 'started') {
        final downloadId = result['download_url']?.split('/').last;

        if (downloadId != null) {
          final downloadInfo = DownloadInfo(
            id: downloadId,
            url: url,
            status: DownloadStatus.pending,
            createdAt: DateTime.now(),
          );

          _downloads[downloadId] = downloadInfo;
          notifyListeners();

          // Start polling if not already polling
          if (!_isPolling) {
            startPolling();
          }

          return downloadInfo;
        }
      }

      return null;
    } catch (e) {
      print('Error starting download: $e');
      return null;
    }
  }

  // Update download statuses
  Future<void> _updateDownloadStatuses() async {
    try {
      final downloads = await ApiService.getAllDownloads();

      for (final download in downloads) {
        final downloadId = download['id'] ?? download.keys.first;
        final status = download['status'];

        if (_downloads.containsKey(downloadId)) {
          final currentInfo = _downloads[downloadId]!;

          // Only update if status changed
          if (currentInfo.status != _parseStatus(status)) {
            _downloads[downloadId] = DownloadInfo(
              id: downloadId,
              url: download['url'] ?? currentInfo.url,
              title: download['title'] ?? currentInfo.title,
              uploader: download['uploader'] ?? currentInfo.uploader,
              thumbnail: download['thumbnail'] ?? currentInfo.thumbnail,
              status: _parseStatus(status),
              error: download['error'],
              createdAt: currentInfo.createdAt,
              completedAt: download['completed_at'] != null
                  ? DateTime.parse(download['completed_at'])
                  : currentInfo.completedAt,
            );

            notifyListeners();
          }
        } else {
          // Add new download
          _downloads[downloadId] = DownloadInfo.fromMap({
            'id': downloadId,
            ...download,
          });
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error updating download statuses: $e');
    }
  }

  // Get specific download status
  Future<DownloadInfo?> getDownloadStatus(String downloadId) async {
    try {
      final status = await ApiService.getDownloadStatus(downloadId);

      if (status != null) {
        final downloadInfo = DownloadInfo.fromMap({
          'id': downloadId,
          ...status,
        });

        _downloads[downloadId] = downloadInfo;
        notifyListeners();
        return downloadInfo;
      }

      return null;
    } catch (e) {
      print('Error getting download status: $e');
      return null;
    }
  }

  // Delete a download
  Future<bool> deleteDownload(String downloadId) async {
    try {
      final success = await ApiService.deleteDownload(downloadId);

      if (success) {
        _downloads.remove(downloadId);
        notifyListeners();
      }

      return success;
    } catch (e) {
      print('Error deleting download: $e');
      return false;
    }
  }

  // Clear all downloads
  void clearDownloads() {
    _downloads.clear();
    notifyListeners();
  }

  // Get downloads by status
  List<DownloadInfo> getDownloadsByStatus(DownloadStatus status) {
    return _downloads.values
        .where((download) => download.status == status)
        .toList();
  }

  // Get completed downloads
  List<DownloadInfo> get completedDownloads =>
      getDownloadsByStatus(DownloadStatus.completed);

  // Get pending downloads
  List<DownloadInfo> get pendingDownloads =>
      getDownloadsByStatus(DownloadStatus.pending);

  // Get failed downloads
  List<DownloadInfo> get failedDownloads =>
      getDownloadsByStatus(DownloadStatus.failed);

  static DownloadStatus _parseStatus(String? status) {
    switch (status) {
      case 'pending':
        return DownloadStatus.pending;
      case 'downloading':
        return DownloadStatus.downloading;
      case 'completed':
        return DownloadStatus.completed;
      case 'failed':
        return DownloadStatus.failed;
      default:
        return DownloadStatus.pending;
    }
  }

  @override
  void dispose() {
    stopPolling();
    super.dispose();
  }
}
