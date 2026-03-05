import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import '../constants/api_constants.dart';

class DioClient {
  final Dio _dio;

  DioClient(CacheOptions cacheOptions)
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        ) {
    _dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }

  Future<Response> get(String path) async {
    return await _dio.get(path);
  }
}
