import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tractorapp/Screens/Profile.screen/Account_information.screen/Change_password.dart';
import '../api.config.dart';
 final String baseUrl = dotenv.env['BASE_URL'] ??'';
  final  Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
class AuthService {
  static final apiService = ApiService();
  static Future<http.Response> logIn(String username, String password) async {
    Map<String, String> data = {
      'username': username,
      'password': password,
    };
    try {
      final response = await apiService.post(
        '/auth/login',
        data,
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
       final response = await apiService.post(
        '/users/deleteDeviceToken',
        data,
      );
       prefs.clear();
       return response;
    } catch (e) {
       throw Exception('Failed to deletee: $e');
    }
   }


   static Future changePassword() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? uid  = prefs.getString('uid');
      final String? deviceToken  = prefs.getString('deviceToken');
       Map<String, String> data = {
      'token': deviceToken??'',
      'uid': uid??'',
    };
    try {
       final response = await apiService.post(
        '/users/deleteDeviceToken',
        data,
      );
       prefs.clear();
       return response;
    } catch (e) {
       throw Exception('Failed to deletee: $e');
    }
   }
}
