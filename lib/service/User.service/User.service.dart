import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer';
import 'dart:async';

final String baseUrl =
    dotenv.env['BASE_URL'] ?? ''; // Thay thế bằng base URL của bạn
final Map<String, String> headers = {
  'Content-Type': 'application/json',
};

class UserService {
  static Future<http.Response> saveDeviceToken(String token, String uid) async {
    
    try {
      Map<String, String> data = {
        'token': token,
        'uid': uid,
      };
      final res = await http.post(
        Uri.parse('$baseUrl/api/v1/users/saveDeviceToken'),
        headers: headers,
        body: jsonEncode(data),
      );
      log(res.body);
      return res;
    } catch (e) {
      throw Exception('Failed to save device token: $e');
    }
  }

  static Future<http.Response> getLimitNoti(String userId) async {
    final client = http.Client();
    try {
      Map<String, String> data = {
        'userId': userId,
      };
      final response = client.post(
        Uri.parse('$baseUrl/api/v1/notifications/getLimitNoti'),
        headers: headers,
        body: jsonEncode(data),
      );
      final res = await response.timeout(Duration(seconds: 10));
      return res;
    } on TimeoutException catch (_) {
      client.close();
      throw Exception('Failed to get tractors: Request timed out');
    } catch (e) {
      client.close();
      throw Exception('Failed to save device token: $e');
    } finally {
      client.close();
    }
  }

  static Future<http.Response> getAllNoti(String userId) async {
    final client = http.Client();
    try {
      Map<String, String> data = {
        'userId': userId,
      };
      final response = client.post(
          Uri.parse('$baseUrl/api/v1/notifications/getNoti'),
          headers: headers,
          body: jsonEncode(data));
      final res = await response.timeout(Duration(seconds: 10));
      //  log(res.body);
      return res;
    } on TimeoutException catch (_) {
      client.close();
      throw Exception('Failed to get tractors: Request timed out');
    } catch (e) {
      client.close();
      throw Exception('Failed to get tractors: $e');
    } finally {
      client.close();
    }
  }
}
