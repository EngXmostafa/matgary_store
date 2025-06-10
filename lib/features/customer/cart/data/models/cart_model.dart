import '../../domain/entities/cart_entity.dart';
import 'cart_item_model.dart';
class CartModel extends CartEntity {
  CartModel({required List<CartItemModel> items, required double total, required double discount, required double finalTotal})
      : super(items: items, total: total, discount: discount, finalTotal: finalTotal);

  factory CartModel.fromMap(Map<String, dynamic> m) => CartModel(
    items: List<Map<String, dynamic>>.from(m['cart_items']).map((e) => CartItemModel.fromMap(e)).toList(),
    total: (m['total'] as num).toDouble(),
    discount: (m['discount'] as num? ?? 0).toDouble(),
    finalTotal: (m['final_total'] as num? ?? m['total']).toDouble(),
  );
}
