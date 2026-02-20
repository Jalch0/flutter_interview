import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/wishlist_repository.dart';

class RemoveFromWishlist
    implements UseCase<void, RemoveFromWishlistParams> {
  const RemoveFromWishlist(this._repository);

  final WishlistRepository _repository;

  @override
  Future<Either<Failure, void>> call(
    RemoveFromWishlistParams params,
  ) =>
      _repository.removeFromWishlist(
        countryCode: params.countryCode,
      );
}

class RemoveFromWishlistParams {
  const RemoveFromWishlistParams({
    required this.countryCode,
  });

  final String countryCode;
}
