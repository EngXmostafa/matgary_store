import '../../domain/entities/slider_entity.dart';

class SliderModel extends SliderEntity {
  const SliderModel({
    required super.id,
    required super.banner,
    required super.type,
    required super.title,
    required super.startingPrice,
  });

  factory SliderModel.fromJson(Map<String, dynamic> j) {
    return SliderModel(
      id: j['id'] as int,
      banner: j['banner'] as String,
      type: j['type'] as String,
      title: j['title'] as String,
      startingPrice: j['starting_price'].toString(),
    );
  }
}
