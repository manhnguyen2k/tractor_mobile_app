import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
class AuthService {
  static final String baseUrl = dotenv.env['BASE_URL'] ??''; // Thay thế bằng base URL của bạn

  static Future<http.Response> logIn(String username, String password) async {
    // Dữ liệu gửi đi
    Map<String, String> data = {
      'username': username,
      'password': password,
    };

    // Cấu hình header
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    // Gửi yêu cầu HTTP POST
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/auth/login'),
        headers: headers,
        body: jsonEncode(data),
      );
  debugPrint('1111111111111111111');
      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
