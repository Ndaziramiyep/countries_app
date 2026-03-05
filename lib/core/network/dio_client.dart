/// HTTP Client with Caching Support
/// 
/// Wraps Dio with cache interceptor for offline support and reduced API calls.
library;

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import '../constants/api_constants.dart';

/// HTTP client with automatic caching
class DioClient {
  final Dio _dio;

  /// Creates a DioClient with cache interceptor
  /// 
  /// [cacheOptions] Configuration for HTTP caching behavior
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

  /// Performs GET request with automatic caching
  /// 
  /// [path] API endpoint path
  /// Returns cached response if available, otherwise fetches from network
  Future<Response> get(String path) async {
    return await _dio.get(path);
  }
}
