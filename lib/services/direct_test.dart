import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class DirectTest {
  static Future<void> testStepByStep() async {
    print('🚀 Starting direct step-by-step test...');
    print('📍 Base URL: ${ApiConfig.baseUrl}');

    // Step 1: Test basic connectivity
    print('\n1️⃣ Testing basic connectivity...');
    try {
      final response = await http
          .get(Uri.parse('${ApiConfig.baseUrl}/health'))
          .timeout(const Duration(seconds: 10));

      print('✅ Health check: ${response.statusCode}');
      print('📄 Response: ${response.body}');
    } catch (e) {
      print('❌ Health check failed: $e');
      return;
    }

    // Step 2: Test video info endpoint
    print('\n2️⃣ Testing video info endpoint...');
    try {
      final response = await http
          .post(
            Uri.parse('${ApiConfig.baseUrl}/api/video/info'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
            }),
          )
          .timeout(const Duration(seconds: 30));

      print('✅ Video info: ${response.statusCode}');
      print('📄 Response: ${response.body}');
    } catch (e) {
      print('❌ Video info failed: $e');
    }

    // Step 3: Test download endpoint
    print('\n3️⃣ Testing download endpoint...');
    try {
      final response = await http
          .post(
            Uri.parse('${ApiConfig.baseUrl}/api/video/download'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
            }),
          )
          .timeout(const Duration(seconds: 30));

      print('✅ Download: ${response.statusCode}');
      print('📄 Response: ${response.body}');
    } catch (e) {
      print('❌ Download failed: $e');
    }

    print('\n🏁 Direct test completed!');
  }
}
