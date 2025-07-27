import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoTitle;
  final String videoUploader;
  final String videoThumbnail;
  final String? videoUrl; // Add video URL for actual playback

  const VideoPlayerScreen({
    super.key,
    required this.videoTitle,
    required this.videoUploader,
    required this.videoThumbnail,
    this.videoUrl,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool _isPlaying = false;
  final bool _isMuted = false;
  final bool _isFullscreen = false;
  final bool _isRepeating = false;
  double _currentPosition = 0.0;
  final double _totalDuration =
      3.50; // Placeholder for total duration (in minutes)
  final double _volume = 1.0;

  @override
  Widget build(BuildContext context) {
    const Color darkBackground = Color(
      0xFF1A1A2E,
    ); // يمكن استخدامه للخلفية المتدرجة
    const Color greyText = Color(0xFFAAAAAA);

    return Scaffold(
      backgroundColor: darkBackground,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.7,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  ),
                ),
              ),
            ),
          ),
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                  stops: [0.3, 1.0], // يبدأ التدرج من 30% من الأعلى
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video Player Placeholder
                Container(
                  margin: const EdgeInsets.all(24.0),
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: widget.videoUrl != null
                        ? Container(
                            color: Colors.black,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _isPlaying ? Icons.pause : Icons.play_arrow,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Video Player',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Text(
                                    'Tap to play',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            color: Colors.grey[900],
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.video_library,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'No Video Available',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Text(
                                    'Video URL not provided',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.videoTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.videoUploader,
                        style: const TextStyle(color: greyText, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Playback Controls
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // توسيط عناصر التحكم
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.fast_rewind,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          // TODO: Rewind action
                        },
                      ),
                      const SizedBox(width: 24),
                      IconButton(
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 60,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPlaying = !_isPlaying;
                          });
                        },
                      ),
                      const SizedBox(width: 24),
                      IconButton(
                        icon: const Icon(
                          Icons.fast_forward,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          // TODO: Forward action
                        },
                      ),
                      const Spacer(), // للمباعدة بين مجموعات الأيقونات
                      IconButton(
                        icon: const Icon(
                          Icons.shuffle,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          // TODO: Shuffle action
                        },
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(
                          Icons.repeat,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          // TODO: Repeat action
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Seek Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Slider(
                    value: _currentPosition,
                    min: 0,
                    max: _totalDuration,
                    activeColor: Colors.white,
                    inactiveColor: greyText,
                    thumbColor: Colors.white,
                    onChanged: (newValue) {
                      setState(() {
                        _currentPosition = newValue;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_currentPosition),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        _formatDuration(_totalDuration),
                        style: const TextStyle(color: greyText, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(double minutes) {
    int totalSeconds = (minutes * 60).round();
    int min = totalSeconds ~/ 60;
    int sec = totalSeconds % 60;
    return '${min.toString().padLeft(1, '0')}:${sec.toString().padLeft(2, '0')}';
  }
}
