
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/login_request.dart';
import '../entities/login_response.dart';
import '../repositories/auth_repositories.dart';

class LoginUseCase {

  final AuthRepositories _authRepositories;

  LoginUseCase(this._authRepositories);

  Future<Either<Failure, LoginResponse>> call(LoginRequest data)async{
    return await _authRepositories.login(data);
  }
}