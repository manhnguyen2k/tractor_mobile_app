import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer';
 final String baseUrl = dotenv.env['BASE_URL'] ??''; // Thay thế bằng base URL của bạn
  
class TractorService {
   static Future<http.Response> getAllTractor() async{
      try {
        final res =  await http.get(
        Uri.parse('$baseUrl/api/v1/tractors'),
      );
        return res;
      } catch (e) {
           throw Exception('Failed to get tractors: $e');
      }
   }
}