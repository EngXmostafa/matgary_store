import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class GetCartUseCase {
  final CartRepository repo;
  GetCartUseCase(this.repo);

  Future<Either<Failure, CartEntity>> call() => repo.getCart();
}