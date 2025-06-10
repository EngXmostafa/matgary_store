
import 'package:dio/dio.dart';
import '../../../../../core/errors/failures.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/coupon_entity.dart';

abstract class CartRemoteDataSource {
  Future<CartEntity> getCart();
  Future<void> addToCart(String productId, int qty);
  Future<double> updateItem(String id, int qty);
  Future<void> removeItem(String id);
  Future<void> clearCart();
  Future<CouponEntity> applyCoupon(String code);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final Dio authDio;
  CartRemoteDataSourceImpl(this.authDio);

  @override
  Future<CartEntity> getCart() async {
    final r = await authDio.get('/api/cart');
    if (r.statusCode == 200 && r.data['status'] == 'success') {
      return CartEntity.fromMap(r.data);
    }
    throw ServerException(statusCode: r.statusCode!, message: r.data['message']);
  }

  @override
  Future<void> addToCart(String productId, int qty) async {
    final r = await authDio.post('/api/cart/add',
        data: {'product_id': productId, 'quantity': qty}
    );
    if (r.statusCode != 200 || r.data['status'] != 'success') {
      throw ServerException(statusCode: r.statusCode!, message: r.data['message']);
    }
  }

  @override
  Future<double> updateItem(String id, int qty) async {
    final r = await authDio.put('/api/cart/update/$id',
        data: {'quantity': qty}
    );
    if (r.statusCode == 200 && r.data['status'] == 'success') {
      return (r.data['subtotal'] as num).toDouble();
    }
    throw ServerException(statusCode: r.statusCode!, message: r.data['message']);
  }

  @override
  Future<void> removeItem(String id) async {
    final r = await authDio.delete('/api/cart/remove/$id');
    if (r.statusCode != 200 || r.data['status'] != 'success') {
      throw ServerException(statusCode: r.statusCode!, message: r.data['message']);
    }
  }

  @override
  Future<void> clearCart() async {
    final r = await authDio.delete('/api/cart/clear');
    if (r.statusCode != 200 || r.data['status'] != 'success') {
      throw ServerException(statusCode: r.statusCode!, message: r.data['message']);
    }
  }

  @override
  Future<CouponEntity> applyCoupon(String code) async {
    final r = await authDio.post('/api/cart/apply-coupon', data: {'code': code});
    if (r.statusCode == 200 && r.data['status'] == 'success') {
      return CouponEntity.fromMap(r.data);
    }
    throw ServerException(statusCode: r.statusCode!, message: r.data['message']);
  }
}