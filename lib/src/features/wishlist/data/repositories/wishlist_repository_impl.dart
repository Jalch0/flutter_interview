import 'package:dartz/dartz.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../../core/error/failures.dart';
import '../../../countries/domain/entities/country.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/wishlist_local_data_source.dart';
import '../models/wishlist_country_model.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  const WishlistRepositoryImpl({
    required WishlistLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  final WishlistLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, void>> saveToWishlist({
    required Country country,
  }) async {
    try {
      final model = WishlistCountryModel.fromEntity(country);
      await _localDataSource.saveCountry(country: model);

      return const Right(null);
    } on SqliteException catch (error) {
      return Left(
        DatabaseFailure(
          message: 'Error en base de datos al guardar: ${error.message}',
        ),
      );
    } catch (error) {
      return Left(
        DatabaseFailure(
          message: 'Error inesperado al guardar wishlist: $error',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Country>>> getWishlist() async {
    try {
      final models = await _localDataSource.getWishlist();
      final countries = models
          .map((model) => model.toEntity())
          .toList(growable: false);

      return Right(countries);
    } on SqliteException catch (error) {
      return Left(
        DatabaseFailure(
          message: 'Error en base de datos al leer: ${error.message}',
        ),
      );
    } catch (error) {
      return Left(
        DatabaseFailure(
          message: 'Error inesperado al obtener wishlist: $error',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> removeFromWishlist({
    required String countryCode,
  }) async {
    try {
      await _localDataSource.removeCountry(countryCode: countryCode);

      return const Right(null);
    } on SqliteException catch (error) {
      return Left(
        DatabaseFailure(
          message: 'Error en base de datos al eliminar: ${error.message}',
        ),
      );
    } catch (error) {
      return Left(
        DatabaseFailure(
          message: 'Error inesperado al eliminar wishlist: $error',
        ),
      );
    }
  }
}
