import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hvdc_user/controllers/auth_controller.dart';
import 'package:hvdc_user/utils/urls.dart';

class ApiHelper {
  static final String _baseUrl = mainUrl;
  static Future<dynamic> get(String endpoint,
      {Map<String, String>? headers}) async {
    return await _sendRequest(
      http.get(Uri.parse('$_baseUrl$endpoint'), headers: headers),
    );
  }

  static Future<dynamic> post(String endpoint, dynamic body,
      {Map<String, String>? headers}) async {
    return await _sendRequest(
      http.post(Uri.parse('$_baseUrl$endpoint'),
          body: jsonEncode(body), headers: headers),
    );
  }

  static Future<dynamic> put(String endpoint, dynamic body,
      {Map<String, String>? headers}) async {
    return await _sendRequest(
      http.put(Uri.parse('$_baseUrl$endpoint'),
          body: jsonEncode(body), headers: headers),
    );
  }

  static Future<dynamic> delete(String endpoint, dynamic body,
      {Map<String, String>? headers}) async {
    return await _sendRequest(
      http.delete(Uri.parse('$_baseUrl$endpoint'),
          body: jsonEncode(body), headers: headers),
    );
  }

  static Future<dynamic> _sendRequest(Future<http.Response> request) async {
    try {
      final response = await request;
      final statusCode = response.statusCode;
      final body = jsonDecode(response.body);

      if (statusCode >= 200 && statusCode < 300) {
        return body;
      } else {
        if (statusCode == 401) {
          AuthController authController = Get.put(AuthController());
          bool isLogin = authController.isLogin();
          if (!kIsWeb) {
            authController.logout();
          } else if (isLogin) {
            authController.logout();
          }
          throw Exception("Please login first!");
        } else if (statusCode == 400) {
          throw Exception(body['detail']);
        } else if (statusCode == 404) {
          throw Error.throwWithStackTrace("not_found", StackTrace.current);
        } else {
          throw Exception('Request failed with status code: $statusCode');
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
