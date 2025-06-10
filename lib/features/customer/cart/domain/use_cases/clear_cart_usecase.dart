import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../repositories/cart_repository.dart';



class ClearCartUseCase {
  final CartRepository repo;
  ClearCartUseCase(this.repo);

  Future<Either<Failure, String>> call() => repo.clearCart();
}