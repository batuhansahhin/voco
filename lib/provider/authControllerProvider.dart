import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco/api/auth_api.dart';
import 'package:voco/controlles/auth_controller.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  final authApi = ref.read(authApiProvider);

  return AuthController(authApi);
});
