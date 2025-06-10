import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

class GetHomeUseCase {
  final HomeRepository _repo;
  GetHomeUseCase(this._repo);
  Future<Either<Failure, HomeEntity>> call() {
    return _repo.getHomeData();
  }
}
