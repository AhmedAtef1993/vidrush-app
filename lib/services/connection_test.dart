import 'package:http/http.dart' as http;
import 'api_service.dart';

class ConnectionTest {
  static Future<void> testBackendConnection() async {
    print('🔍 Testing backend connection...');

    try {
      // Test 1: Basic connectivity
      print('Testing basic connectivity to: ${ApiService.baseUrl}');
      final response = await http
          .get(
            Uri.parse('${ApiService.baseUrl}/health'),
            headers: ApiService.headers,
          )
          .timeout(const Duration(seconds: 10));

      print('✅ Health check response: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('🎉 Backend is accessible!');
      } else {
        print('⚠️ Backend responded with status: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Connection failed: $e');
      print('');
      print('🔧 Troubleshooting tips:');
      print('1. Make sure the backend is running on port 8000');
      print('2. If using Android emulator, use 10.0.2.2:8000');
      print('3. If using physical device, use your computer\'s IP address');
      print('4. Check if firewall is blocking the connection');
      print('5. Try running: cd backend && python main.py');
    }
  }

  static Future<void> testVideoInfo() async {
    print('🔍 Testing video info endpoint...');

    try {
      final testUrl =
          'https://www.youtube.com/watch?v=dQw4w9WgXcQ'; // Rick Roll for testing
      final response = await http
          .post(
            Uri.parse('${ApiService.baseUrl}/api/video/info'),
            headers: ApiService.headers,
            body: '{"url": "$testUrl"}',
          )
          .timeout(const Duration(seconds: 30));

      print('✅ Video info response: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print('❌ Video info test failed: $e');
    }
  }
}
