import 'package:dio/dio.dart';

abstract class HomeRemoteDataSource {
  Future<Response> fetchHomeData();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio _dio;
  HomeRemoteDataSourceImpl(this._dio);

  @override
  Future<Response> fetchHomeData() {
    return _dio.get('/api/home');
  }
}
