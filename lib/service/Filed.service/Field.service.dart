import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';
import '../api.config.dart';

final String baseUrl = dotenv.env['BASE_URL'] ?? '';

class FieldService {
  static final apiService = ApiService();
  static Future<http.Response> getAllField() async {
    try {
      final response = await apiService.get(
        '/fields/get_all_fields',
      );

      return response;
    } catch (e) {
      throw Exception('Failed to get fields: $e');
    }
  }

  static Future<http.Response> addField(Map<String, dynamic> payload) async {
    try {
      final response = await apiService.post('/fields/createfield', payload);

      return response;
    } catch (e) {
      throw Exception('Failed to create fields: $e');
    }
  }
}
