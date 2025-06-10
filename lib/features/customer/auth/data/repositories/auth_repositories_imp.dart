import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/errors/failures.dart';

import '../../domain/entities/login_request.dart';
import '../../domain/entities/login_response.dart';
import '../../domain/entities/register_request.dart';
import '../../domain/repositories/auth_repositories.dart';
import '../data_sources/auth_interface_data_source.dart';
import '../models/customer_model.dart';

class AuthRepositoriesImp implements AuthRepositories {
  final AuthInterfaceDataSource _authInterfaceDataSource;

  AuthRepositoriesImp(this._authInterfaceDataSource);

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest data) async {
    try {
      final response = await _authInterfaceDataSource.login(data);
      if (response.statusCode == 200) {
        var data = LoginModel.fromJson(response.data as Map<String, dynamic>);
        return Right(data);
      } else {
        final message =
            response.data is Map && response.data['message'] is String
                ? response.data['message'] as String
                : 'Login failed';
        return Left(
          ServerFailure(
            statusCode: response.statusCode.toString(),
            message: response.data['message'],
          ),
        );
      }
    } on DioException catch (dioException) {
      final code = dioException.response?.statusCode?.toString() ?? '0';
      final message = dioException.response?.data is Map && dioException.response!.data['message'] is String
      ? dioException.response!.data['message'] as String
      : dioException.message;
      return Left(
        ServerFailure(
          statusCode: code,
          message: message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> register(RegisterRequest data) async {
    try {
      final response = await _authInterfaceDataSource.register(data);
      final code = response.statusCode??0;

       if (code>=200 && code<300) {




        return const Right(true);
      }

      final message =
          response.data is Map && response.data['message'] is String
              ? response.data['message'] as String
              : 'Registration failed';
      return Left(
        ServerFailure(
          statusCode:code.toString(),
          message: message,
        ),
      );
    } on DioException catch (e) {

      // network / HTTP error
      final code = e.response?.statusCode?.toString() ?? '0';
      final message =
          e.response?.data is Map && e.response!.data['message'] is String
              ? e.response!.data['message'] as String
              : e.message;
      return Left(ServerFailure(statusCode: code, message: message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // your protected logout endpoint
      await _authInterfaceDataSource.logout();
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(
        statusCode: e.response?.statusCode.toString() ?? '0',
        message: e.response?.data['message'] ?? e.message,
      ));
    }
  }
}
