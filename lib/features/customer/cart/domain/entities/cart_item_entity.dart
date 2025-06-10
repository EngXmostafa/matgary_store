import 'product_entity.dart';

class CartItemEntity {
  final String id;
  final ProductEntity product;
  final int quantity;

  CartItemEntity({
    required this.id,
    required this.product,
    required this.quantity,
  });

  factory CartItemEntity.fromMap(Map<String, dynamic> map) {
    return CartItemEntity(
      id: map['id'].toString()??'',
      product: ProductEntity.fromMap(map['product']),

        quantity: int.tryParse(map['quantity'].toString()) ?? 0,

    );
  }
}