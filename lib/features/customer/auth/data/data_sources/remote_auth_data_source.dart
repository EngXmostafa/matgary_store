import 'package:dio/dio.dart';

import '../../domain/entities/login_request.dart';
import '../../domain/entities/register_request.dart';
import 'auth_interface_data_source.dart';

class RemoteAuthDataSource implements AuthInterfaceDataSource {
  final Dio _dio;

  RemoteAuthDataSource(this._dio);

  @override
  Future<Response> login(LoginRequest data) async {
    return await _dio.post(
        "/api/user/login",
        data: data.toJson());
  }

  @override
  Future<Response> register(RegisterRequest data) async {
    return await _dio.post(
        "/api/user/register",
        data: data.toJson());
  }

  @override
  Future<Response> logout() {
    return _dio.post('/api/logout');
  }

}

