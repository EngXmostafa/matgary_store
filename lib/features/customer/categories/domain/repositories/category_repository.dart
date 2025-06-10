import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/category_feature.dart';

abstract class CategoryRepository {
  Future<Either<Failure, FeaturePack>> getFeaturePack({required bool refresh});
}
