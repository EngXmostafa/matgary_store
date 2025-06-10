import 'package:dio/dio.dart';
import '../models/wishlist_item_model.dart';

abstract class WishlistRemoteDataSource {
  Future<List<WishlistItemModel>> getWishlist();
  Future<void> addToWishlist(String productId);
  Future<void> removeFromWishlist(String productId);
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final Dio dio;
  WishlistRemoteDataSourceImpl(this.dio);

  @override
  Future<List<WishlistItemModel>> getWishlist() async {
    final response = await dio.get('/api/wishlist');
    if (response.data['status'] == 'success') {
      final data = response.data['data'] as List;
      return data.map((e) => WishlistItemModel.fromJson(e)).toList();
    }
    throw Exception(response.data['message'] ?? 'Failed to fetch wishlist');
  }

  @override
  Future<void> addToWishlist(String productId) async {
    final response = await dio.post('/api/wishlist/add', queryParameters: {'id': productId});
    if (response.data['status'] != 'success') {
      throw Exception(response.data['message']);
    }
  }

  @override
  Future<void> removeFromWishlist(String productId) async {
    print('[Wishlist] Removing product id: $productId');
    final response = await dio.delete('/api/wishlist/remove/$productId');
    print('[Wishlist] Remove response: ${response.data}');
    if (response.data['status'] != 'success') {
      print('[Wishlist] Remove failed: ${response.data['message']}');
      throw Exception(response.data['message']);
    } else {
      print('[Wishlist] Remove succeeded for product id: $productId');
    }
  }
}
