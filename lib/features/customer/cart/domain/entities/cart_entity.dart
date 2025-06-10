
import 'cart_item_entity.dart';

class CartEntity {
  final List<CartItemEntity> items;
  final double total;
  final double discount;
  final double finalTotal;

  CartEntity({
    required this.items,
    required this.total,
    required this.discount,
    required this.finalTotal,
  });

  factory CartEntity.fromMap(Map<String, dynamic> map) {
    return CartEntity(
      items: (map['cart_items'] as List? ?? [])
          .map((item) => CartItemEntity.fromMap(item as Map<String, dynamic>))
          .toList(),
      total: double.tryParse(map['total']?.toString() ?? '0') ?? 0.0,
      discount: double.tryParse(map['discount']?.toString() ?? '0') ?? 0.0,
      finalTotal: double.tryParse(map['final_total']?.toString() ?? '0') ?? 0.0,
    );
  }
  // factory CartEntity.fromMap(Map<String, dynamic> map) {
  //   return CartEntity(
  //     items: List<CartItemEntity>.from(
  //       (map['cart_items'] as List)
  //           .map((item) => CartItemEntity.fromMap(item as Map<String, dynamic>)),
  //     ),
  //     total: (map['total'] as num).toDouble(),
  //     discount: (map['discount'] as num).toDouble(),
  //     finalTotal: (map['final_total'] as num).toDouble(),
  //   );
  // }
}