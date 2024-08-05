import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer';
 final String baseUrl = dotenv.env['BASE_URL'] ??''; // Thay thế bằng base URL của bạn
  
class UserService {
   static Future<http.Response> saveDeviceToken(String token, String uid) async{
      try {
        Map<String, String> data = {
      'token': token,
      'uid': uid,
    };

    // Cấu hình header
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
        final res =  await http.post(
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
    static Future<http.Response> getNoti(String userId) async{
      log('aaaaaaaaaaaaa$userId');
      try {
        Map<String, String> data = {
      'userId': userId,
     
    };

    // Cấu hình header
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
        final res =  await http.post(
        Uri.parse('$baseUrl/api/v1/notifications/getNoti'),
        headers: headers,
        body: jsonEncode(data),
      );
    //  log(res.body);
        return res;
        
      } catch (e) {
           throw Exception('Failed to save device token: $e');
      }
   }
}