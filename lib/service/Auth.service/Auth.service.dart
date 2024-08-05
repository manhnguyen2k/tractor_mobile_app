import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
 final String baseUrl = dotenv.env['BASE_URL'] ??''; // Thay thế bằng base URL của bạn
  final  Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
class AuthService {
  
  static Future<http.Response> logIn(String username, String password) async {
    // Dữ liệu gửi đi
    Map<String, String> data = {
      'username': username,
      'password': password,
    };

    // Cấu hình header
   

    // Gửi yêu cầu HTTP POST
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/auth/login'),
        headers: headers,
        body: jsonEncode(data),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
   static Future logOut() async {
    
     final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? uid  = prefs.getString('uid');
      final String? deviceToken  = prefs.getString('deviceToken');
       Map<String, String> data = {
      'token': deviceToken??'',
      'uid': uid??'',
    };
    try {
       final response = await http.post(
        Uri.parse('$baseUrl/api/v1/users/deleteDeviceToken'),
        headers: headers,
        body: jsonEncode(data),
      );
       prefs.clear();
       return response;
    } catch (e) {
       throw Exception('Failed to deletee: $e');
    }
    
   }
}
