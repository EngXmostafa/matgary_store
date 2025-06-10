class ProductEntity {
  final String id;
  final String name;
  final String thumbImage;
  final String brandId;
  final double price;
  final double? offerPrice;

  ProductEntity({
    required this.id,
    required this.name,
    required this.thumbImage,
    required this.brandId,
    required this.price,
    this.offerPrice,
  });
}
