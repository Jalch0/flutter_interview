import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/country_detail.dart';
import '../repositories/country_repository.dart';

class GetCountryDetails
    implements UseCase<CountryDetail, GetCountryDetailsParams> {
  const GetCountryDetails(this._repository);

  final CountryRepository _repository;

  @override
  Future<Either<Failure, CountryDetail>> call(
    GetCountryDetailsParams params,
  ) =>
      _repository.getCountryDetails(
        countryName: params.countryName,
      );
}

class GetCountryDetailsParams {
  const GetCountryDetailsParams({
    required this.countryName,
  });

  final String countryName;
}
