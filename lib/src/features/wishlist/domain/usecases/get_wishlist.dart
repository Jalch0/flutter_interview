import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../../../countries/domain/entities/country.dart';
import '../repositories/wishlist_repository.dart';

class GetWishlist implements UseCase<List<Country>, NoParams> {
  const GetWishlist(this._repository);

  final WishlistRepository _repository;

  @override
  Future<Either<Failure, List<Country>>> call(NoParams params) =>
      _repository.getWishlist();
}
