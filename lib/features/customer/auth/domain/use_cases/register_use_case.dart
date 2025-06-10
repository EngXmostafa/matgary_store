import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/register_request.dart';
import '../repositories/auth_repositories.dart';

class RegisterUseCase {

  final AuthRepositories _authRepositories;

  RegisterUseCase(this._authRepositories);

  Future<Either<Failure,bool>>  call(RegisterRequest data)async{
    return await _authRepositories.register(data);
  }
}