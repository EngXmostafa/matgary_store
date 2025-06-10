import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../domain/entities/wishlist_item_entity.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../data_sources/wishlist_remote_data_source.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource remote;
  WishlistRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<WishlistItemEntity>>> getWishlist() async {
    try {
      final list = await remote.getWishlist();
      return Right(list);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: ''));
    }
  }

  @override
  Future<Either<Failure, Unit>> addToWishlist(String productId) async {
    try {
      await remote.addToWishlist(productId);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: ''));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromWishlist(String productId) async {
    try {
      await remote.removeFromWishlist(productId);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: ''));
    }
  }
}
