import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_interview/src/features/wishlist/data/db/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('guarda y obtiene países desde Drift correctamente', () async {
    await database.wishlistDao.insertCountry(
      country: WishlistTableCompanion.insert(
        countryCode: 'DE',
        commonName: 'Germany',
        officialName: 'Federal Republic of Germany',
        flagEmoji: '🇩🇪',
        flagPng: 'https://flagcdn.com/w320/de.png',
        capitalsJson: const Value('["Berlin"]'),
        population: 83240525,
        region: 'Europe',
        subregion: 'Western Europe',
      ),
    );

    final rows = await database.wishlistDao.getAllCountries();

    expect(rows, hasLength(1));
    expect(rows.first.countryCode, 'DE');
    expect(rows.first.commonName, 'Germany');
  });

  test('elimina país guardado correctamente', () async {
    await database.wishlistDao.insertCountry(
      country: WishlistTableCompanion.insert(
        countryCode: 'IT',
        commonName: 'Italy',
        officialName: 'Italian Republic',
        flagEmoji: '🇮🇹',
        flagPng: 'https://flagcdn.com/w320/it.png',
        capitalsJson: const Value('["Rome"]'),
        population: 58853482,
        region: 'Europe',
        subregion: 'Southern Europe',
      ),
    );

    await database.wishlistDao.deleteCountryByCode(countryCode: 'IT');

    final rows = await database.wishlistDao.getAllCountries();
    expect(
      rows.where((row) => row.countryCode == 'IT'),
      isEmpty,
    );
  });
}
