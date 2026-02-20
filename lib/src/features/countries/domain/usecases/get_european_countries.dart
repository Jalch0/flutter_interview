import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/country.dart';
import '../repositories/country_repository.dart';

class GetEuropeanCountries implements UseCase<List<Country>, NoParams> {
  const GetEuropeanCountries(this._repository);

  final CountryRepository _repository;

  @override
  Future<Either<Failure, List<Country>>> call(NoParams params) =>
      _repository.getEuropeanCountries();
}
