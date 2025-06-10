import 'slider_entity.dart';
import 'brand_entity.dart';
import 'product_entity.dart';
import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  final List<SliderEntity> sliders;
  final List<BrandEntity> brands;
  final Map<String, List<ProductEntity>> typeBaseProducts;
  const HomeEntity({
    required this.sliders,
    required this.brands,
    required this.typeBaseProducts,
  });
  @override List<Object?> get props => [sliders, brands, typeBaseProducts];
}
