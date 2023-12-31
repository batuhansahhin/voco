import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voco/api/auth_api.dart';
import '../models/login_response.dart';

class AuthController {
  final AuthApi _authApi;

  AuthController(this._authApi);

  Future<AuthResult> loginUser(String email, String password) async {
    try {
      LoginResponse response = await _authApi.loginUser(email, password);

      if (response.successful ?? false) {
        if (response.token != null &&
            response.token!.isNotEmpty &&
            response.error == null) {
          await _saveToken(response.token!);

          return AuthResult.success(response.token!);
        } else {
          if (response.error == 'Invalid credentials') {
            return AuthResult.failure('Şifre yanlış');
          }
          return AuthResult.failure(response.error ?? 'Giriş başarısız oldu');
        }
      } else {
        return AuthResult.failure(response.error ?? 'Giriş başarısız oldu');
      }
    } catch (e) {
      return AuthResult.error('Bir hata oluştu: $e');
    }
  }

  Future<AuthResult> loginWithToken() async {
    try {
      String? token = await _retrieveToken();

      if (token != null && token.isNotEmpty) {
        LoginResponse response = await _authApi.loginWithToken(token);

        if (response.successful ?? false) {
          return AuthResult.success(response.token!);
        } else {
          return AuthResult.failure(response.error ?? 'Giriş başarısız oldu');
        }
      } else {
        return AuthResult.failure('Token bulunamadı');
      }
    } catch (e) {
      return AuthResult.error('Bir hata oluştu: $e');
    }
  }

  Future<bool> hasToken() async {
    String? token = await _retrieveToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> _retrieveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    String? debugToken = await _retrieveToken();
    if (kDebugMode) {
      print('Debug: Token after logout: $debugToken');
    }
  }
}

enum AuthResultType { success, failure, error }

class AuthResult {
  final AuthResultType type;
  final String message;
  final String token;

  AuthResult.success(this.token)
      : type = AuthResultType.success,
        message = '';

  AuthResult.failure(this.message)
      : type = AuthResultType.failure,
        token = '';

  AuthResult.error(this.message)
      : type = AuthResultType.error,
        token = '';
}
