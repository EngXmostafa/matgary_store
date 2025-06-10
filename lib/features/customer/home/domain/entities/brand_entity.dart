import 'package:equatable/equatable.dart';

class BrandEntity extends Equatable {
  final int id;
  final String logo, name, slug;
  const BrandEntity({
    required this.id,
    required this.logo,
    required this.name,
    required this.slug,
  });
  @override List<Object?> get props => [id, logo, name, slug];
}
