import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class NetworkTest {
  static Future<void> testNetworkAccess() async {
    print('🌐 Testing network access to Railway backend...');
    print('📍 Target URL: ${ApiConfig.baseUrl}');

    // Test 1: Basic HTTP request without any special headers
    print('\n1️⃣ Testing basic HTTP GET request...');
    try {
      final response = await http
          .get(Uri.parse('${ApiConfig.baseUrl}/health'))
          .timeout(const Duration(seconds: 15));

      print('✅ Basic HTTP request successful: ${response.statusCode}');
      print('📄 Response: ${response.body}');
    } catch (e) {
      print('❌ Basic HTTP request failed: $e');
      print('💡 This suggests a network connectivity issue');
    }

    // Test 2: Test with different user agent
    print('\n2️⃣ Testing with custom user agent...');
    try {
      final response = await http
          .get(
            Uri.parse('${ApiConfig.baseUrl}/health'),
            headers: {'User-Agent': 'VidRush-App/1.0'},
          )
          .timeout(const Duration(seconds: 15));

      print('✅ Custom user agent request successful: ${response.statusCode}');
    } catch (e) {
      print('❌ Custom user agent request failed: $e');
    }

    // Test 3: Test POST request
    print('\n3️⃣ Testing POST request...');
    try {
      final response = await http
          .post(
            Uri.parse('${ApiConfig.baseUrl}/api/video/info'),
            headers: {
              'Content-Type': 'application/json',
              'User-Agent': 'VidRush-App/1.0',
            },
            body: jsonEncode({
              'url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
            }),
          )
          .timeout(const Duration(seconds: 30));

      print('✅ POST request successful: ${response.statusCode}');
      print('📄 Response: ${response.body}');
    } catch (e) {
      print('❌ POST request failed: $e');
    }

    print('\n🏁 Network test completed!');
  }
}
