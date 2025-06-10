import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../repositories/auth_repositories.dart';

class LogoutUseCase {
  final AuthRepositories _repo;
  LogoutUseCase(this._repo);

  Future<Either<Failure, void>> call() => _repo.logout();
}