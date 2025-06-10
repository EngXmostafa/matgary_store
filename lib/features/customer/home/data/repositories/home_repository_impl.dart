import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/errors/failures.dart';
import '../data_sources/home_remote_data_source.dart';
import '../models/home_model.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _ds;
  HomeRepositoryImpl(this._ds);

  @override
  Future<Either<Failure, HomeEntity>> getHomeData() async {
    try {
      final resp = await _ds.fetchHomeData();
      final home = HomeModel.fromJson(resp.data as Map<String, dynamic>);
      return Right(home);
    } on DioException catch (e) {
      return Left(ServerFailure(
        statusCode: e.response?.statusCode.toString() ?? '0',
        message: e.response?.data['message'] ?? e.message,
      ));
    }
  }
}
