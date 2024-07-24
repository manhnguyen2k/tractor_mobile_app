import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';
 final String baseUrl = dotenv.env['BASE_URL'] ??''; // Thay thế bằng base URL của bạn
  
class FieldService {
  
  static Future<http.Response> getAllField() async {
    // Dữ liệu gửi đi
    
    // Cấu hình header
   

    // Gửi yêu cầu HTTP POST
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/v1/fields/get_all_fields'),
      );

      return response;
    } catch (e) {
      throw Exception('Failed to get fields: $e');
    }
  }
  static Future<http.Response> addField(Map<String, dynamic> payload) async {
    // Dữ liệu gửi đi
    
    // Cấu hình header
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    // Gửi yêu cầu HTTP POST
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/fields/createfield'), 
        headers: headers,
         body: jsonEncode(payload),
      );

      return response;
    } catch (e) {
      throw Exception('Failed to create fields: $e');
    }
  }
}
