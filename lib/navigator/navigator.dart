import 'package:flutter/material.dart';
import 'package:voco/api/auth_api.dart';
import 'package:voco/views/home_page.dart';
import 'package:voco/views/login_page.dart';

class AppNavigator {
  static void goToHomePage(BuildContext context, AuthApi authApi) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage(authApi: authApi)),
    );
  }

  static void goToLoginIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
