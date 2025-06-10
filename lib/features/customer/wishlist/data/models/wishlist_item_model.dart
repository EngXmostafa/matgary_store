import '../../domain/entities/wishlist_item_entity.dart';
import 'product_model.dart';

class WishlistItemModel extends WishlistItemEntity {
  WishlistItemModel({
    required super.id,
    required super.productId,
    required super.userId,
    required super.product,
  });

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      id: json['id'].toString(),
      productId: json['product_id'].toString(),
      userId: json['user_id'].toString(),
      product: ProductModel.fromJson(json['product']),
    );
  }
}
