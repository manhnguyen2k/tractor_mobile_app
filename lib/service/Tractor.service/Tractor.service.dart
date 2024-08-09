import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer';
import 'dart:async';

final String baseUrl = dotenv.env['BASE_URL'] ?? ''; // Thay thế bằng base URL của bạn

class TractorService {
  static Future<http.Response> getAllTractor() async {
    final client = http.Client();
    try {
      final responseFuture = client.get(Uri.parse('$baseUrl/api/v1/tractors'));
      final response = await responseFuture.timeout(Duration(seconds: 10));
      return response;
    } on TimeoutException catch (_) {
      client.close(); // Cancel the connection
      throw Exception('Failed to get tractors: Request timed out');
    } catch (e) {
      client.close(); // Ensure connection is closed in case of other errors
      throw Exception('Failed to get tractors: $e');
    } finally {
      client.close(); // Ensure the client is closed to prevent resource leaks
    }
  }
}
