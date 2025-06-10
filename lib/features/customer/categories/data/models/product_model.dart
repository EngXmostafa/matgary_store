import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.thumbImage,
    required super.categoryId,
    super.subCategoryId,
    super.childCategoryId,
    required super.price,
    super.offerPrice,
    required super.brandId,
  });

  factory ProductModel.fromMap(Map<String, dynamic> m) {
    return ProductModel(
      id:              m['id'].toString(),
      name:            m['name'],
      thumbImage:      m['thumb_image'],
      categoryId:      m['category_id'].toString(),
      subCategoryId:   m['sub_category_id']?.toString(),
      childCategoryId: m['child_category_id']?.toString(),
      price:           (m['price'] as num).toDouble(),
      offerPrice:      m['offer_price'] != null
          ? (m['offer_price'] as num).toDouble()
          : null,
      brandId:  m['brand_id'].toString(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'thumb_image': thumbImage,
    'category_id': categoryId,
    'sub_category_id': subCategoryId,
    'child_category_id': childCategoryId,
    'price': price,
    'offer_price': offerPrice,
    'brand_id':brandId,
  };

  static List<ProductModel> fromList(List<dynamic> list) =>
      list.map((item) => ProductModel.fromMap(item)).toList();
}
