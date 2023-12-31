import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco/api/auth_api.dart';
import 'package:voco/navigator/navigator.dart';
import 'package:voco/provider/authControllerProvider.dart';
import 'package:voco/views/login_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider);

    return MaterialApp(
      title: 'Voco',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: authController.hasToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            final bool hasToken = snapshot.data ?? false;
            if (hasToken) {
              final authApiInstance = AuthApi();
              Future.delayed(Duration.zero, () {
                AppNavigator.goToHomePage(context, authApiInstance);
              });
              return Container();
            } else {
              return const LoginPage();
            }
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
