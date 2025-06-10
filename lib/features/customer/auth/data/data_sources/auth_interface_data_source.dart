import 'package:dio/dio.dart';

import '../../domain/entities/login_request.dart';
import '../../domain/entities/register_request.dart';

abstract  class AuthInterfaceDataSource {
 Future<Response> login(LoginRequest data);
 Future<Response> register(RegisterRequest data);
 Future<Response> logout();
}

