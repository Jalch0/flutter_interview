import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/country.dart';
import '../entities/country_detail.dart';

abstract class CountryRepository {
  Future<Either<Failure, List<Country>>> getEuropeanCountries();

  Future<Either<Failure, CountryDetail>> getCountryDetails({
    required String countryName,
  });
}
