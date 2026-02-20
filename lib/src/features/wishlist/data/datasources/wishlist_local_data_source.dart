import '../db/wishlist_dao.dart';
import '../models/wishlist_country_model.dart';

abstract class WishlistLocalDataSource {
  Future<void> saveCountry({
    required WishlistCountryModel country,
  });

  Future<List<WishlistCountryModel>> getWishlist();

  Future<void> removeCountry({
    required String countryCode,
  });
}

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  const WishlistLocalDataSourceImpl({
    required WishlistDao wishlistDao,
  }) : _wishlistDao = wishlistDao;

  final WishlistDao _wishlistDao;

  @override
  Future<void> saveCountry({
    required WishlistCountryModel country,
  }) async {
    await _wishlistDao.insertCountry(
      country: country.toCompanion(),
    );
  }

  @override
  Future<List<WishlistCountryModel>> getWishlist() async {
    final rows = await _wishlistDao.getAllCountries();

    return rows
        .map(WishlistCountryModel.fromTableData)
        .toList(growable: false);
  }

  @override
  Future<void> removeCountry({
    required String countryCode,
  }) async {
    await _wishlistDao.deleteCountryByCode(
      countryCode: countryCode,
    );
  }
}
