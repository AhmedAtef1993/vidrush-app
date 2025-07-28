import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class SimpleTest {
  static Future<void> testConnection() async {
    print('🧪 Starting simple connection test...');

    try {
      // Test 1: Basic HTTP request
      print('1️⃣ Testing basic HTTP request...');
      final response = await http
          .get(Uri.parse('${ApiConfig.baseUrl}/health'))
          .timeout(const Duration(seconds: 10));

      print('✅ Health check successful: ${response.statusCode}');
      print('Response: ${response.body}');
    } catch (e) {
      print('❌ Health check failed: $e');
    }

    try {
      // Test 2: Video info with simple URL
      print('2️⃣ Testing video info with simple URL...');
      final response = await http
          .post(
            Uri.parse('${ApiConfig.baseUrl}/api/video/info'),
            headers: {'Content-Type': 'application/json'},
            body: '{"url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"}',
          )
          .timeout(const Duration(seconds: 30));

      print('✅ Video info successful: ${response.statusCode}');
      print('Response: ${response.body}');
    } catch (e) {
      print('❌ Video info failed: $e');
    }
  }
}
