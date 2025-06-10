import '/features/customer/wishlist/domain/entities/product_entity.dart';

class WishlistItemEntity {
  final String id;
  final String productId;
  final String userId;
  final ProductEntity product;

  WishlistItemEntity({
    required this.id,
    required this.productId,
    required this.userId,
    required this.product,
  });
}

