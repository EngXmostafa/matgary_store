import 'package:equatable/equatable.dart';
class LoginResponse  extends Equatable{
  final String username;
  final String email;
  final String token;

  const LoginResponse ({
    required this.username,
    required this.email,
    required this.token,
  });

  @override

  List<Object?> get props =>[
    username,
    email,
    token


  ];
}
