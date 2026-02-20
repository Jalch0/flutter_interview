import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class RestCountriesDio {
  RestCountriesDio._();

  static const String baseUrl = 'https://restcountries.com/v3.1';

  static CacheOptions buildCacheOptions({
    CacheStore? cacheStore,
  }) {
    return CacheOptions(
      store: cacheStore ?? MemCacheStore(),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403, 404],
      maxStale: const Duration(days: 30),
    );
  }

  static Dio buildDio({
    required CacheOptions cacheOptions,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    dio.interceptors.add(
      DioCacheInterceptor(options: cacheOptions),
    );

    return dio;
  }
}
