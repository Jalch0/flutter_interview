import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../countries/domain/entities/country.dart';

abstract class WishlistRepository {
  Future<Either<Failure, void>> saveToWishlist({
    required Country country,
  });

  Future<Either<Failure, List<Country>>> getWishlist();

  Future<Either<Failure, void>> removeFromWishlist({
    required String countryCode,
  });
}
