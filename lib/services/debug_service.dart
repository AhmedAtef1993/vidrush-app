import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import 'api_service.dart';

class DebugService {
  static Future<Map<String, dynamic>> testAllEndpoints() async {
    final results = <String, dynamic>{};

    try {
      // Test 1: Health check
      print('🔍 Testing health endpoint...');
      final healthResponse = await http
          .get(
            Uri.parse('${ApiConfig.baseUrl}/health'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      results['health'] = {
        'status': healthResponse.statusCode,
        'body': healthResponse.body,
        'success': healthResponse.statusCode == 200,
      };

      // Test 2: Video info endpoint
      print('🔍 Testing video info endpoint...');
      final videoInfoResponse = await http
          .post(
            Uri.parse('${ApiConfig.baseUrl}/api/video/info'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
            }),
          )
          .timeout(const Duration(seconds: 30));

      results['video_info'] = {
        'status': videoInfoResponse.statusCode,
        'body': videoInfoResponse.body,
        'success': videoInfoResponse.statusCode == 200,
      };

      // Test 3: Download endpoint
      print('🔍 Testing download endpoint...');
      final downloadResponse = await http
          .post(
            Uri.parse('${ApiConfig.baseUrl}/api/video/download'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
            }),
          )
          .timeout(const Duration(seconds: 30));

      results['download'] = {
        'status': downloadResponse.statusCode,
        'body': downloadResponse.body,
        'success': downloadResponse.statusCode == 200,
      };

      // Test 4: Downloads list endpoint
      print('🔍 Testing downloads list endpoint...');
      final downloadsResponse = await http
          .get(
            Uri.parse('${ApiConfig.baseUrl}/api/downloads'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      results['downloads_list'] = {
        'status': downloadsResponse.statusCode,
        'body': downloadsResponse.body,
        'success': downloadsResponse.statusCode == 200,
      };
    } catch (e) {
      results['error'] = e.toString();
    }

    return results;
  }

  static void printDebugInfo() {
    print('🔧 Debug Information:');
    print('Base URL: ${ApiConfig.baseUrl}');
    print('Is Development: ${ApiConfig.isDevelopment}');
    print('Headers: ${ApiService.headers}');
  }
}
