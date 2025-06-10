import '../../domain/entities/brand_entity.dart';

class BrandModel extends BrandEntity {
  const BrandModel({
    required super.id,
    required super.logo,
    required super.name,
    required super.slug,
  });

  factory BrandModel.fromJson(Map<String, dynamic> j) {
    return BrandModel(
      id:   j['id']   as int,
      logo: j['logo'] as String,
      name: j['name'] as String,
      slug: j['slug'] as String,
    );
  }
}
