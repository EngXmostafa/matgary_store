class ProductEntity {
  final String id;
  final String name;
  final String thumbImage;
  final double price;
  final double offerPrice;
  final String category;
  ProductEntity({
    required this.id,
    required this.name,
    required this.thumbImage,
    required this.price,
    required this.offerPrice,
    required this.category,
  });

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      id: map['id']?.toString() ?? '',
      name: map['name'] ?? 'Unnamed',
      thumbImage: map['thumb_image'] ?? '',
      price: double.tryParse(map['price']?.toString() ?? '0') ?? 0.0,
      offerPrice: double.tryParse(map['offer_price']?.toString() ?? '0') ?? 0.0,
      category: map['category']? ['name'] ??'unknown',
    );
  }
}