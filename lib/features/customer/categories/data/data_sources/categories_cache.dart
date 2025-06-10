// lib/categories/data/data_sources/categories_cache.dart

import '../../../../../core/services/_index.dart';
import '../models/brand_model.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../../domain/entities/category_feature.dart';

class CategoriesCache {
  static const _key = 'feature_pack_cache';

  static Future<void> save(FeaturePack pack) async {
    final map = {
      'brands': pack.brands.map((e) => (e as BrandModel).toMap()).toList(),
      'categories': pack.categories.map((e) => (e as CategoryModel).toMap()).toList(),
      'products': pack.products.map((e) => (e as ProductModel).toMap()).toList(),
    };
    await CacheHelper.setJson(_key, map);
  }


  static Future<FeaturePack?> load() async {
    final map = await CacheHelper.getJson(_key);
    if (map == null) return null;
    return FeaturePack(
      brands: (map['brands'] as List).map((e) => BrandModel.fromMap(e)).toList(),
      categories: (map['categories'] as List).map((e) => CategoryModel.fromMap(e)).toList(),
      products: (map['products'] as List).map((e) => ProductModel.fromMap(e)).toList(),
    );
  }

  static Future<void> clear() async => CacheHelper.remove(_key);
}
