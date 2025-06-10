import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../data_sources/cart_remote_data_source.dart';

import '../../domain/repositories/cart_repository.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/coupon_entity.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remote;
  CartRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, CartEntity>> getCart() async {
    try {
      final cart = await remote.getCart();
      return Right(cart);
    } on ServerException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode.toString(), message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> addToCart(String productId, int qty) async {
    try {
      await remote.addToCart(productId, qty);
      return const Right('Added to cart!');
    } on ServerException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode.toString(), message: e.message));
    }
  }

  @override
  Future<Either<Failure, double>> updateItem(String id, int qty) async {
    try {
      final subtotal = await remote.updateItem(id, qty);
      return Right(subtotal);
    } on ServerException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode.toString(), message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeItem(String id) async {
    try {
      await remote.removeItem(id);
      return const Right('Item removed');
    } on ServerException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode.toString(), message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> clearCart() async {
    try {
      await remote.clearCart();
      return const Right('Cart cleared');
    } on ServerException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode.toString(), message: e.message));
    }
  }

  @override
  Future<Either<Failure, CouponEntity>> applyCoupon(String code) async {
    try {
      final coupon = await remote.applyCoupon(code);
      return Right(coupon);
    } on ServerException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode.toString(), message: e.message));
    }
  }
}