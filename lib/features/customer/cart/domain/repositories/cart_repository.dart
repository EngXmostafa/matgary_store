import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/cart_entity.dart';
import '../entities/coupon_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>> getCart();
  Future<Either<Failure, String>> addToCart(String productId, int qty);
  Future<Either<Failure, double>> updateItem(String id, int qty);
  Future<Either<Failure, String>> removeItem(String id);
  Future<Either<Failure, String>> clearCart();
  Future<Either<Failure, CouponEntity>> applyCoupon(String code);
}