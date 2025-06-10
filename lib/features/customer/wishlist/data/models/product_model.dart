import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.thumbImage,
    required super.brandId,
    required super.price,
    super.offerPrice,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'],
      thumbImage: json['thumb_image'],
      brandId: json['brand_id'].toString(),
      price: (json['price'] as num).toDouble(),
      offerPrice: json['offer_price'] != null ? (json['offer_price'] as num).toDouble() : null,
    );
  }
}
