// lib/core/services/web_services.dart

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import 'cache_helper.dart';

class WebServices {
  final Dio publicDio;
  final Dio authDio;
  static const _tokenKey = 'Authorization';

  WebServices({required this.publicDio, required this.authDio}) {
    // both clients share the same base URL & timeouts
    final url = Constants.baseURL!;
    for (final client in [publicDio, authDio]) {
      client.options
        ..baseUrl = url
        ..connectTimeout = const Duration(seconds: 5)
        ..receiveTimeout = const Duration(seconds: 5)
        ..followRedirects = false
        ..validateStatus = (status) => status != null && status < 500;
    }
    _initInterceptors();
  }

  Future<void> loadToken() async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey) ?? '';
    if ( token.isNotEmpty) {
      log('✅ Loaded Token: $token');
      authDio.options.headers['Authorization'] = 'Bearer $token';
    }else{
      log('❌ No token found in SharedPreferences');
    }
  }

  void _initInterceptors() {
    publicDio.interceptors
      ..clear()
      ..add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            log('▶ PUBLIC: ${options.method} ${options.uri.path}');
            handler.next(options);
          },
          onError: (error, handler) {
            EasyLoading.dismiss();
            handler.next(error);
          },
        ),
      );

    authDio.interceptors
      ..clear()
      ..add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            await loadToken();
            log('▶ AUTH:   ${options.method} ${options.uri.path}');
            log('📤 Headers: ${authDio.options.headers}');
            handler.next(options);
          },
          onError: (error, handler) {
            EasyLoading.dismiss();
            final code = error.response?.statusCode;
            if (code == 401 || code == 403) {
              CacheHelper.removeKey(_tokenKey);
            }
            handler.next(error);
          },
        ),
      );
  }
}
