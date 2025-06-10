import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/wishlist_item_entity.dart';

abstract class WishlistRepository {
  Future<Either<Failure, List<WishlistItemEntity>>> getWishlist();
  Future<Either<Failure, Unit>> addToWishlist(String productId);
  Future<Either<Failure, Unit>> removeFromWishlist(String productId);
}
