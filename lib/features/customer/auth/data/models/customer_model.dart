
import '../../domain/entities/login_response.dart';


class LoginModel extends LoginResponse {
  const LoginModel({
    required super.username,
    required super.email,
    required super.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    // The API wraps user info under "user"
    final user = json['user'] as Map<String, dynamic>;

    return LoginModel(
      username: user['name'] as String,        // use the "name" field
      email: user['email'] as String,          // email is here as well
      token: json['token'] as String,          // token at top level
    );
  }
}