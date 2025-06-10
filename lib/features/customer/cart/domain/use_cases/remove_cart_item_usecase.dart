import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../repositories/cart_repository.dart';

class RemoveCartItemUseCase {
  final CartRepository repo;
  RemoveCartItemUseCase(this.repo);

  Future<Either<Failure, String>> call(String id) => repo.removeItem(id);
}