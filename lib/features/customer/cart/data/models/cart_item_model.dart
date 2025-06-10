import '../../domain/entities/cart_item_entity.dart';
import 'product_model.dart';
class CartItemModel extends CartItemEntity {
  CartItemModel({required String id, required int quantity, required ProductModel product})
      : super(id: id, quantity: quantity, product: product);

  factory CartItemModel.fromMap(Map<String, dynamic> m) => CartItemModel(
    id: m['id'].toString(),
    quantity: m['quantity'],
    product: ProductModel.fromMap(m['product']),
  );
}