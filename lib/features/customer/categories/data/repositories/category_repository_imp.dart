import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/_index.dart';
import '../../domain/entities/category_feature.dart';
import '../../domain/repositories/category_repository.dart';
import '../data_sources/category_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remote;
  CategoryRepositoryImpl(this.remote);
  static const _cacheKey = 'featurePack';
  static const _cacheDuration = Duration(minutes:15 );
  @override
  Future<Either<Failure, FeaturePack>> getFeaturePack({bool refresh = false}) async {
    try {
      // If not refreshing, try to load from cache
      if (!refresh) {
        final cachedJson = await CacheHelper.getJson(_cacheKey);
        if (cachedJson != null) {
          final fp = FeaturePack.fromJson(cachedJson);
          return Right(fp);
        }
      }

      // Fetch from network, save to cache
      final fp = await remote.fetchAll();
      await CacheHelper.setJson(_cacheKey, fp.toJson());
      return Right(fp);
    } on DioException catch (e) {
      // On network error, try cache as fallback
      final cachedJson = await CacheHelper.getJson(_cacheKey);
      if (cachedJson != null) {
        final fp = FeaturePack.fromJson(cachedJson);
        return Right(fp);
      }
      final code = e.response?.statusCode?.toString() ?? '';
      return Left(ServerFailure(
        statusCode: code,
        message:    e.message,
      ));
    } catch (e) {
      return Left(ServerFailure(
        statusCode: '',
        message:    e.toString(),
      ));
    }
  }
}
