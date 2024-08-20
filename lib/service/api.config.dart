import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../values/app_constants.dart';

class ApiService {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final Map<String, String> headers = AppConstants.headers;

  Future<http.Response> get(String endpoint) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/v1$endpoint'))
          .timeout(AppConstants.timeout);
      return response;
    } on http.ClientException catch (e) {
      throw Exception('Client error: $e');
    } on Exception catch (e) {
      throw Exception('Request timeout or failed: $e');
    }
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/v1$endpoint'),
            headers: headers,
            body: jsonEncode(data),
          )
          .timeout(AppConstants.timeout);
      return response;
    } on http.ClientException catch (e) {
      throw Exception('Client error: $e');
    } on Exception catch (e) {
      throw Exception('Request timeout or failed: $e');
    }
  }
}
