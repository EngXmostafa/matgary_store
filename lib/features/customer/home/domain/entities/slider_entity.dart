import 'package:equatable/equatable.dart';

class SliderEntity extends Equatable {
  final int id;
  final String banner, type, title, startingPrice;
  const SliderEntity({
    required this.id,
    required this.banner,
    required this.type,
    required this.title,
    required this.startingPrice,
  });
  @override List<Object?> get props => [id, banner, type, title, startingPrice];
}
