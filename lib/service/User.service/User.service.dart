import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer';
import 'dart:async';
import '../../values/app_constants.dart';
import '../api.config.dart';

final String baseUrl = dotenv.env['BASE_URL'] ?? '';
final Map<String, String> headers = {
  'Content-Type': 'application/json',
};

class UserService {
  static final apiService = ApiService();
  static Future<http.Response> saveDeviceToken(String token, String uid) async {
    try {
      Map<String, String> data = {
        'token': token,
        'uid': uid,
      };
      final res = await apiService.post('/users/saveDeviceToken', data);
      //log(res.body);
      return res;
    } catch (e) {
      throw Exception('Failed to save device token: $e');
    }
  }

  static Future<http.Response> getLimitNoti(String userId) async {
    // final client = http.Client();
    try {
      Map<String, String> data = {
        'userId': userId,
      };
      final response =
          await apiService.post('/notifications/getLimitNoti', data);
      return response;
    } catch (e) {
      throw Exception('Failed to get limit notifications: $e');
    }
  }

  static Future<http.Response> getAllNoti(String userId) async {
    try {
      Map<String, String> data = {
        'userId': userId,
      };
      final response = await apiService.post('/notifications/getNoti', data);
      return response;
    } catch (e) {
      throw Exception('Failed to get tractors: $e');
    }
  }
}
