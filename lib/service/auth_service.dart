import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

import '../models/login_response.dart';

final authServiceDataProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthService {
  static const String baseUrl = 'https://reqres.in/api/login';

  Future<LoginResponse> loginUser(String email, String password) async {
    final Map<String, String> requestData = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(Uri.parse(baseUrl), body: requestData);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return LoginResponse.fromJson(jsonResponse);
      } else if (response.statusCode == 400) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return LoginResponse.fromJson(jsonResponse);
      } else {
        return LoginResponse(successful: false, error: 'Unexpected response');
      }
    } catch (e) {
      return LoginResponse(successful: false, error: 'Error: $e');
    }
  }
}
