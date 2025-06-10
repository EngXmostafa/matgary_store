import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name, thumbImage;
  final double price;
  final double
  ? offerPrice;
  const ProductEntity({
    required this.id,
    required this.name,
    required this.thumbImage,
    required this.price,
    this.offerPrice,
  });
  @override List<Object?> get props => [id, name, thumbImage, price, offerPrice];
}
