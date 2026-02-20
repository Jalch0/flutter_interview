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
    final response = await _dio.get('/region/europe');
    final data = response.data;

    if (data is! List) {
      throw const FormatException(
        'Lista de países formato no válido',
      );
    }

    return data
        .map(
          (item) => CountryModel.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<CountryDetailModel> getCountryDetails({
    required String countryName,
  }) async {
    final encodedCountryName = Uri.encodeComponent(countryName);
    final detailCacheOptions = _cacheOptions.copyWith(
      policy: CachePolicy.forceCache,
      keyBuilder: ({
        required Uri url,
        Map<String, String>? headers,
        Object? body,
      }) {
        final normalized = countryName.trim().toLowerCase();
        return 'country_detail_$normalized';
      },
    );

    final response = await _dio.get(
      '/translation/$encodedCountryName',
      options: detailCacheOptions.toOptions(),
    );

    final data = response.data;

    if (data is! List || data.isEmpty) {
      throw const FormatException(
        'Country detail formato no válido',
      );
    }

    return CountryDetailModel.fromJson(
      Map<String, dynamic>.from(data.first as Map),
    );
  }
}
