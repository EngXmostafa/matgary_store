import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/category_feature.dart';
import '../repositories/category_repository.dart';

class GetCategoryFeature {
  final CategoryRepository repository;
  GetCategoryFeature(this.repository);

  Future<Either<Failure, FeaturePack>> call({bool refresh = false}) {
    return repository.getFeaturePack(refresh: refresh);
  }
}
