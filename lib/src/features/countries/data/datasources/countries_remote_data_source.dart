import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import '../models/country_detail_model.dart';
import '../models/country_model.dart';

abstract class CountriesRemoteDataSource {
  Future<List<CountryModel>> getEuropeanCountries();

  Future<CountryDetailModel> getCountryDetails({
    required String countryName,
  });
}

class CountriesRemoteDataSourceImpl implements CountriesRemoteDataSource {
  CountriesRemoteDataSourceImpl({
    required Dio dio,
    required CacheOptions cacheOptions,
  })  : _dio = dio,
        _cacheOptions = cacheOptions;

  final Dio _dio;
  final CacheOptions _cacheOptions;

  @override
  Future<List<CountryModel>> getEuropeanCountries() async {
    try {
      final options = _cacheOptions
          .copyWith(
            maxStale: const Nullable(Duration(hours: 24)),
          )
          .toOptions();

      final response = await _dio.get(
        '/region/europe',
        options: options,
      );

      final data = response.data;

      if (data == null || data is! List) {
        throw const RestCountriesException(
            'Formato de lista de países no válido');
      }

      return data
          .cast<Map<String, dynamic>>()
          .map(CountryModel.fromJson)
          .toList(growable: false);
    } on DioException catch (e) {
      throw RestCountriesException.fromDioException(e);
    } catch (e) {
      throw RestCountriesException('Error inesperado: $e');
    }
  }

  @override
  Future<CountryDetailModel> getCountryDetails({
    required String countryName,
  }) async {
    try {
      final encodedCountryName = Uri.encodeComponent(countryName);

      final detailCacheOptions = _cacheOptions.copyWith(
        policy: CachePolicy.forceCache,
        maxStale: const Nullable(Duration(days: 7)),
        keyBuilder: (request) {
          final normalized = countryName.trim().toLowerCase();
          return 'country_detail_$normalized';
        },
      );

      final response = await _dio.get(
        '/name/$encodedCountryName',
        queryParameters: {'fullText': true},
        options: detailCacheOptions.toOptions(),
      );

      final data = response.data;

      if (data == null || data is! List || data.isEmpty) {
        throw const RestCountriesException('Detalle del país no encontrado');
      }

      return CountryDetailModel.fromJson(
        Map<String, dynamic>.from(data.first as Map),
      );
    } on DioException catch (e) {
      throw RestCountriesException.fromDioException(e);
    } catch (e) {
      throw RestCountriesException('Error inesperado: $e');
    }
  }
}

class RestCountriesException implements Exception {
  const RestCountriesException(this.message);

  factory RestCountriesException.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const RestCountriesException(
            'Tiempo de conexión agotado. Revisa tu internet.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return const RestCountriesException('País no encontrado.');
        } else if (statusCode == 500) {
          return const RestCountriesException('Error interno del servidor.');
        }
        return RestCountriesException(
          'HTTP $statusCode: ${e.response?.statusMessage ?? 'Error desconocido'}',
        );
      case DioExceptionType.cancel:
        return const RestCountriesException('Petición cancelada.');
      case DioExceptionType.connectionError:
        return const RestCountriesException('No hay conexión a internet.');
      case DioExceptionType.badCertificate:
        return const RestCountriesException(
            'Error de seguridad en la conexión.');
      case DioExceptionType.unknown:
        return RestCountriesException('Error de red: ${e.message}');
    }
  }

  final String message;

  @override
  String toString() => message;
}
