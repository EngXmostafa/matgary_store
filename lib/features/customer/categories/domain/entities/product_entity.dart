class ProductEntity {
  final String id;
  final String name;
  final String thumbImage;
  final String categoryId;
  final String? subCategoryId;
  final String? childCategoryId;
  final double price;
  final double? offerPrice;
  final String brandId;

  ProductEntity({
    required this.id,
    required this.name,
    required this.thumbImage,
    required this.categoryId,
    this.subCategoryId,
    this.childCategoryId,
    required this.price,
    this.offerPrice,
    required this.brandId,
  });
}
