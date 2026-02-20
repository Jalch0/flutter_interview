import 'package:drift/drift.dart';

import 'app_database.dart';

part 'wishlist_dao.g.dart';

@DriftAccessor(tables: [WishlistTable])
class WishlistDao extends DatabaseAccessor<AppDatabase>
    with _$WishlistDaoMixin {
  WishlistDao(super.attachedDatabase);

  Future<void> insertCountry({
    required WishlistTableCompanion country,
  }) async {
    await into(wishlistTable).insertOnConflictUpdate(country);
  }

  Future<List<WishlistTableData>> getAllCountries() async {
    return select(wishlistTable).get();
  }

  Future<void> deleteCountryByCode({
    required String countryCode,
  }) async {
    await (delete(wishlistTable)
          ..where((table) => table.countryCode.equals(countryCode)))
        .go();
  }
}
