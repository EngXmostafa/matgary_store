import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/coupon_entity.dart';


abstract class CartState {}

class CartLoading extends CartState {}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}

class CartLoaded extends CartState {
  final CartEntity cart;
  CartLoaded(this.cart);
}

class CartActionSuccess extends CartState {
  final String message;
  CartActionSuccess(this.message);
}

class CouponApplied extends CartState {
  final CouponEntity coupon;
  CouponApplied(this.coupon);
}