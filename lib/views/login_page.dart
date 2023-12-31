import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco/api/auth_api.dart';
import 'package:voco/controlles/auth_controller.dart';
import 'package:voco/navigator/navigator.dart';
import 'package:voco/provider/authControllerProvider.dart';
import 'package:voco/utils/text_field.dart';
import 'package:voco/utils/utils.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final authController = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.loginPageTitle),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/square_up.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleTextField(
                  hintText: AppStrings.emailLabel,
                  labelText: AppStrings.emailLabel,
                  controller: emailController,
                  accentColor: AppColors.primaryColor,
                ),
                const SizedBox(height: 16.0),
                SimpleTextField(
                  hintText: AppStrings.passwordLabel,
                  labelText: AppStrings.passwordLabel,
                  obscureText: true,
                  controller: passwordController,
                  accentColor: AppColors.primaryColor,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    final result = await authController.loginUser(
                      emailController.text,
                      passwordController.text,
                    );

                    if (result.type == AuthResultType.success &&
                        result.token.isNotEmpty) {
                      final authApiInstance = AuthApi();
                      AppNavigator.goToHomePage(context, authApiInstance);
                    } else if (result.type == AuthResultType.failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${AppStrings.loginFailedMessage}${result.message}'),
                          backgroundColor: AppColors.errorColor,
                        ),
                      );
                    } else if (result.type == AuthResultType.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${AppStrings.errorMessage}${result.message}'),
                          backgroundColor: AppColors.errorColor,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor,
                  ),
                  child: const Text(AppStrings.loginButtonLabel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
