import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer';
import 'dart:async';
import '../../values/app_constants.dart';
import '../api.config.dart';

final String baseUrl = dotenv.env['BASE_URL'] ?? '';

class TractorService {
  static final apiService = ApiService();
  static Future<http.Response> getAllTractor() async {
    try {
      final response = apiService.get('/tractors');
      return response;
    } catch (e) {
      throw Exception('Failed to get tractors: $e');
    }
  }
}
