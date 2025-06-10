import 'package:dartz/dartz.dart';


import '../../../../../core/errors/failures.dart';
import '../repositories/cart_repository.dart';

class UpdateCartItemUseCase {
  final CartRepository repo;
  UpdateCartItemUseCase(this.repo);

  Future<Either<Failure, double>> call(String id, int qty) =>
      repo.updateItem(id, qty);
}