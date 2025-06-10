import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.id,
    required super.title,
    required super.slug,
    required super.icon,
    required super.status,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> m) {
    return CategoryModel(
      id:     m['id'].toString(),
      title:  m['name'],
      slug:   m['slug'],
      icon:   m['icon'],
      status: m['status'].toString(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': title,
      'slug': slug,
      'icon': icon,
      'status': status,
    };
  }

  static List<CategoryModel> fromList(List<dynamic> list) =>
      list.map((item) => CategoryModel.fromMap(item)).toList();
}
