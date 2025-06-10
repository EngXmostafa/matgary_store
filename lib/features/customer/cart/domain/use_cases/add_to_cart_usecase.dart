import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repo;
  AddToCartUseCase(this.repo);

  Future<Either<Failure, String>> call(String productId, int qty) =>
      repo.addToCart(productId, qty);
}