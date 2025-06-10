import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.thumbImage,
    required super.price,
    super.offerPrice,
  });

  factory ProductModel.fromJson(Map<String, dynamic> j) {
    return ProductModel(
      id:         j['id']          as int,
      name:       j['name']        as String,
      thumbImage: j['thumb_image'] as String,
      price:      (j['price']      as num).toDouble(),
      offerPrice: j['offer_price'] != null
          ? (j['offer_price'] as num).toDouble()
          : null,
    );
  }
}
