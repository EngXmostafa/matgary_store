import '../../domain/entities/product_entity.dart';
class ProductModel extends ProductEntity {
  ProductModel({required String id, required String name, required String thumbImage, required double price, required double offerPrice,  required String category,})
      : super(id: id, name: name, thumbImage: thumbImage, price: price, offerPrice: offerPrice,category: category);

  factory ProductModel.fromMap(Map<String, dynamic> m) => ProductModel(
    id: m['id'].toString(),
    name: m['name'],
    thumbImage: m['thumb_image'],
    price: (m['price'] as num).toDouble(),
    offerPrice: (m['offer_price'] as num).toDouble(),
    category: m['category']?['name']??'Unknown',
  );
}