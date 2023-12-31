import 'package:flutter/material.dart';

class AppStrings {
  static const String loginPageTitle = 'Login Page';
  static const String emailLabel = 'Email';
  static const String passwordLabel = 'Password';
  static const String loginButtonLabel = 'Login';
  static const String loginFailedMessage = 'Login Failed. Error: ';
  static const String errorMessage = 'An error occurred: ';
  static const String homePageTitle = 'Home Page';
  static const String welcomeMessage = 'Welcome to Home Page!';
  static const String logoutButtonLabel = 'Logout';

  static const TextStyle labelTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
}

class AppColors {
  static const Color primaryColor = Colors.blue;
  static const Color textColor = Colors.black;
  static const Color errorColor = Colors.red;
}

class AppStyles {
  static const TextStyle welcomeMessageStyle = TextStyle(fontSize: 20);
  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static const SizedBox verticalSpacing = SizedBox(height: 20);
}

class AppUtils {
  static EdgeInsets get defaultPadding => AppStyles.defaultPadding;
  static SizedBox get verticalSpacing => AppStyles.verticalSpacing;
}
