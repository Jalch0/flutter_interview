import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../../../countries/domain/entities/country.dart';
import '../repositories/wishlist_repository.dart';

class SaveToWishlist
    implements UseCase<void, SaveToWishlistParams> {
  const SaveToWishlist(this._repository);

  final WishlistRepository _repository;

  @override
  Future<Either<Failure, void>> call(
    SaveToWishlistParams params,
  ) =>
      _repository.saveToWishlist(
        country: params.country,
      );
}

class SaveToWishlistParams {
  const SaveToWishlistParams({
    required this.country,
  });

  final Country country;
}
