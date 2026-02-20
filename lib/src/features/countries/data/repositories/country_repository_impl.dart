import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/country_detail.dart';
import '../../domain/repositories/country_repository.dart';
import '../datasources/countries_remote_data_source.dart';

class CountryRepositoryImpl implements CountryRepository {
  const CountryRepositoryImpl({
    required CountriesRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final CountriesRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<Country>>> getEuropeanCountries() async {
    try {
      final models = await _remoteDataSource.getEuropeanCountries();
      final countries = models
          .map((countryModel) => countryModel.toEntity())
          .toList(growable: false);

      return Right(countries);
    } on DioException catch (error) {
      return Left(
        ServerFailure(
          message: 'Error al obtener países: ${error.message}',
        ),
      );
    } on FormatException catch (error) {
      return Left(
        ServerFailure(
          message: 'Respuesta inválida de países: ${error.message}',
        ),
      );
    } catch (error) {
      return Left(
        ServerFailure(
          message: 'Error inesperado al obtener países: $error',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, CountryDetail>> getCountryDetails({
    required String countryName,
  }) async {
    try {
      final model = await _remoteDataSource.getCountryDetails(
        countryName: countryName,
      );

      return Right(model.toEntity());
    } on DioException catch (error) {
      return Left(
        ServerFailure(
          message: 'Error al obtener detalle: ${error.message}',
        ),
      );
    } on FormatException catch (error) {
      return Left(
        ServerFailure(
          message: 'Detalle inválido del país: ${error.message}',
        ),
      );
    } catch (error) {
      return Left(
        ServerFailure(
          message: 'Error inesperado en detalle: $error',
        ),
      );
    }
  }
}
