import 'package:equatable/equatable.dart';
import '../../domain/entities/category_feature.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
  @override
  List<Object?> get props => [message];
}

class CategoryLoaded extends CategoryState {
  final FeaturePack feature;
  CategoryLoaded(this.feature);
  @override
  List<Object?> get props => [feature];
}
