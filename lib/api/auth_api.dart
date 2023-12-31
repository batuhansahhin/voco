import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';
import '../models/login_response.dart';

class AuthApi {
  static const String _baseUrl = 'https://reqres.in/api/login';

  Future<LoginResponse> loginUser(String email, String password) async {
    try {
      final response = await http.post(Uri.parse(_baseUrl),
          body: {'email': email, 'password': password});

      if (response.statusCode == 200 || response.statusCode == 400) {
        return _parseResponse(response);
      } else {
        return LoginResponse(
            successful: false,
            error: 'Unexpected response status code: ${response.statusCode}');
      }
    } catch (e) {
      return LoginResponse(
          successful: false, error: 'Error during login request: $e');
    }
  }

  LoginResponse _parseResponse(http.Response response) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return LoginResponse.fromJson(jsonResponse);
  }

  Future<LoginResponse> loginWithToken(String token) async {
    try {
      final response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return _parseResponse(response);
      } else {
        return LoginResponse(
            successful: false,
            error: 'Unexpected response status code: ${response.statusCode}');
      }
    } catch (e) {
      return LoginResponse(
          successful: false, error: 'Error during login request: $e');
    }
  }

  bool hasToken() {
    return false;
  }
}

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi();
});
