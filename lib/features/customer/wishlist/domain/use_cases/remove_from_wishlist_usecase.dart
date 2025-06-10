import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../repositories/wishlist_repository.dart';

class RemoveFromWishlistUseCase {
  final WishlistRepository repository;
  RemoveFromWishlistUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String productId) => repository.removeFromWishlist(productId);
}