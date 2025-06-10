import '../../domain/entities/brand_entity.dart';

class BrandModel extends BrandEntity {
  BrandModel({
    required super.id,
    required super.logo,
    required super.name,
    required super.slug,
  });

  factory BrandModel.fromMap(Map<String, dynamic> m) {
    return BrandModel(
      id:   m['id'].toString(),
      logo: m['logo'],
      name: m['name'],
      slug: m['slug'],
    );
  }
  Map<String, dynamic> toMap() => {
    'id': id,
    'logo': logo,
    'name': name,
    'slug': slug,
  };

  static List<BrandModel> fromList(List<dynamic> list) =>
      list.map((item) => BrandModel.fromMap(item)).toList();
}
