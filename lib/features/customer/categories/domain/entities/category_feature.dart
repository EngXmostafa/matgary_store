import 'package:matgary/features/customer/categories/data/models/category_model.dart';
import 'package:matgary/features/customer/categories/data/models/brand_model.dart';
import 'package:matgary/features/customer/categories/data/models/product_model.dart';

import '../../data/models/brand_model.dart';
import 'category_entity.dart';
import 'brand_entity.dart';
import 'product_entity.dart';

class FeaturePack {
  final List<BrandEntity>   brands;
  final List<CategoryEntity> categories;
  final List<ProductEntity> products;

  FeaturePack({
    required this.brands,
    required this.categories,
    required this.products,
  });
  factory FeaturePack.fromJson(Map<String, dynamic> json) {
    return FeaturePack(
      brands: (json['brands'] as List)
          .map((e) => BrandModel.fromMap(e))
          .toList(),
      categories: (json['categories'] as List)
          .map((e) => CategoryModel.fromMap(e))
          .toList(),
      products: (json['products'] as List)
          .map((e) => ProductModel.fromMap(e))
          .toList(),
    );
  }

  // toJson (for caching)
  Map<String, dynamic> toJson() => {
    'brands': brands.map((e) => (e as BrandModel).toMap()).toList(),
    'categories': categories.map((e) => (e as CategoryModel).toMap()).toList(),
    'products': products.map((e) => (e as ProductModel).toMap()).toList(),
  };
}
