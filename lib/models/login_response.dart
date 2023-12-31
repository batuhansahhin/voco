class LoginResponse {
  final bool? successful;
  final String? token;
  final String? error;

  LoginResponse({
    required this.successful,
    this.token,
    this.error,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('token')) {
      return LoginResponse(successful: true, token: json['token']);
    } else if (json.containsKey('error')) {
      return LoginResponse(successful: false, error: json['error']);
    } else {
      return LoginResponse(successful: false, error: 'Unexpected response');
    }
  }
}
