import 'package:dartz/dartz.dart';


import '../../../../../core/errors/failures.dart';
import '../entities/login_request.dart';
import '../entities/login_response.dart';
import '../entities/register_request.dart';

abstract class AuthRepositories {
  Future<Either<Failure,LoginResponse>>login(LoginRequest data);
  Future<Either<Failure,bool>>register(RegisterRequest data);
  Future<Either<Failure, void>> logout();

}