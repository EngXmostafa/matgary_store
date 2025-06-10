import '../../domain/entities/home_entity.dart';
import 'slider_model.dart';
import 'brand_model.dart';
import 'product_model.dart';

class HomeModel extends HomeEntity {
  const HomeModel({
    required super.sliders,
    required super.brands,
    required super.typeBaseProducts,
  });

  factory HomeModel.fromJson(Map<String, dynamic> j) {
    final rawSliders = j['sliders'] as List<dynamic>;
    final rawBrands  = j['brands']  as List<dynamic>;
    final rawMap     = j['typeBaseProducts'] as Map<String, dynamic>;

    return HomeModel(
      sliders: rawSliders.map((e) => SliderModel.fromJson(e)).toList(),
      brands:  rawBrands .map((e) => BrandModel.fromJson(e)).toList(),
      typeBaseProducts: rawMap.map((key, list) =>
          MapEntry(key, (list as List<dynamic>)
              .map((e) => ProductModel.fromJson(e))
              .toList(),
          ),
      ),
    );
  }
}
