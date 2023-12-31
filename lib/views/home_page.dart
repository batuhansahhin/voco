import 'package:flutter/material.dart';
import 'package:voco/api/auth_api.dart';
import 'package:voco/navigator/navigator.dart';
import 'package:voco/controlles/auth_controller.dart';
import 'package:voco/utils/utils.dart';

class HomePage extends StatelessWidget {
  final AuthApi authApi;

  const HomePage({Key? key, required this.authApi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.homePageTitle),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/square_up.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: AppUtils.defaultPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  AppStrings.welcomeMessage,
                  style: AppStyles.welcomeMessageStyle,
                ),
                AppUtils.verticalSpacing,
                ElevatedButton(
                  onPressed: () async {
                    await AuthController(authApi).logout();
                    // ignore: use_build_context_synchronously
                    AppNavigator.goToLoginIn(context);
                  },
                  child: const Text(AppStrings.logoutButtonLabel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
