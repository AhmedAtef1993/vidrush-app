import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ApiService {
  // Get base URL from configuration
  static String get baseUrl => ApiConfig.baseUrl;

  // Headers for API requests
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Health check
  static Future<bool> healthCheck() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
        headers: headers,
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Health check failed: $e');
      return false;
    }
  }

  // Get video information
  static Future<Map<String, dynamic>?> getVideoInfo(String url) async {
    try {
      print('🔗 Using API URL: $baseUrl/api/video/info');
      final response = await http.post(
        Uri.parse('$baseUrl/api/video/info'),
        headers: headers,
        body: jsonEncode({'url': url}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to get video info: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting video info: $e');
      return null;
    }
  }

  // Start video download
  static Future<Map<String, dynamic>?> startDownload(
    String url, {
    String? formatId,
  }) async {
    try {
      final body = {'url': url};
      if (formatId != null) {
        body['format_id'] = formatId;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/api/video/download'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to start download: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error starting download: $e');
      return null;
    }
  }

  // Get download status
  static Future<Map<String, dynamic>?> getDownloadStatus(
    String downloadId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/download/$downloadId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to get download status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting download status: $e');
      return null;
    }
  }

  // Get all downloads
  static Future<List<Map<String, dynamic>>> getAllDownloads() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/downloads'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['downloads'].values);
      } else {
        print('Failed to get downloads: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error getting downloads: $e');
      return [];
    }
  }

  // Delete download
  static Future<bool> deleteDownload(String downloadId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/download/$downloadId'),
        headers: headers,
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting download: $e');
      return false;
    }
  }
}
