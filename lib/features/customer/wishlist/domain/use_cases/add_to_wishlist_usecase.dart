import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../repositories/wishlist_repository.dart';

class AddToWishlistUseCase {
  final WishlistRepository repository;
  AddToWishlistUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String productId) => repository.addToWishlist(productId);
}