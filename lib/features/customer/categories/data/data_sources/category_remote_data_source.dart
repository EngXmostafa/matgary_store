import 'package:dio/dio.dart';
import '../../domain/entities/category_feature.dart';
import '../models/category_model.dart';
import '../models/brand_model.dart';
import '../models/product_model.dart';

abstract class CategoryRemoteDataSource {
  Future<FeaturePack> fetchAll();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio dio;
  CategoryRemoteDataSourceImpl(this.dio);

  @override
  Future<FeaturePack> fetchAll() async {
    final resp = await dio.get('/api/home-products');
    final data = resp.data as Map<String, dynamic>;

    final brands = (data['brands'] as List)
        .map((j) => BrandModel.fromMap(j))
        .toList();

    final categories = (data['categories'] as List)
        .map((j) => CategoryModel.fromMap(j))
        .toList();

    final products = (data['products']['data'] as List)
        .map((j) => ProductModel.fromMap(j))
        .toList();

    return FeaturePack(
      brands:     brands,
      categories: categories,
      products:   products,
    );
  }
}
