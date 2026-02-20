import 'package:flutter_interview/src/core/error/failures.dart';
import 'package:flutter_interview/src/features/countries/domain/entities/country.dart';
import 'package:flutter_interview/src/features/wishlist/data/datasources/wishlist_local_data_source.dart';
import 'package:flutter_interview/src/features/wishlist/data/models/wishlist_country_model.dart';
import 'package:flutter_interview/src/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqlite3/sqlite3.dart';

class MockWishlistLocalDataSource extends Mock
    implements WishlistLocalDataSource {}

class FakeWishlistCountryModel extends Fake
    implements WishlistCountryModel {}

void main() {
  late MockWishlistLocalDataSource localDataSource;
  late WishlistRepositoryImpl repository;

  const country = Country(
    cca2: 'FR',
    commonName: 'France',
    officialName: 'French Republic',
    flagEmoji: '🇫🇷',
    flagPng: 'https://flagcdn.com/w320/fr.png',
    capital: ['Paris'],
    population: 68042591,
    region: 'Europe',
    subregion: 'Western Europe',
  );

  final wishlistModel = WishlistCountryModel.fromEntity(country);

  setUpAll(() {
    registerFallbackValue(FakeWishlistCountryModel());
  });

  setUp(() {
    localDataSource = MockWishlistLocalDataSource();
    repository = WishlistRepositoryImpl(localDataSource: localDataSource);
  });

  // ── saveToWishlist ─────────────────────────────────────────────────────────

  test(
    'saveToWishlist: retorna Right cuando guarda correctamente',
    () async {
      when(
        () => localDataSource.saveCountry(country: any(named: 'country')),
      ).thenAnswer((_) async {});

      final result = await repository.saveToWishlist(country: country);

      expect(result.isRight(), isTrue);
    },
  );

  test(
    'saveToWishlist: retorna DatabaseFailure cuando lanza SqliteException',
    () async {
      when(
        () => localDataSource.saveCountry(country: any(named: 'country')),
      ).thenThrow(SqliteException(1, 'db failure'));

      final result = await repository.saveToWishlist(country: country);

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<DatabaseFailure>()),
        (_) => fail('Se esperaba Failure'),
      );
    },
  );

  // ── getWishlist ────────────────────────────────────────────────────────────

  test(
    'getWishlist: retorna Right con lista de países cuando tiene éxito',
    () async {
      when(
        () => localDataSource.getWishlist(),
      ).thenAnswer((_) async => [wishlistModel]);

      final result = await repository.getWishlist();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Se esperaba Right'),
        (countries) {
          expect(countries, hasLength(1));
          expect(countries.first.cca2, 'FR');
        },
      );
    },
  );

  test(
    'getWishlist: retorna DatabaseFailure cuando lanza SqliteException',
    () async {
      when(
        () => localDataSource.getWishlist(),
      ).thenThrow(SqliteException(1, 'read failure'));

      final result = await repository.getWishlist();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<DatabaseFailure>()),
        (_) => fail('Se esperaba Failure'),
      );
    },
  );

  // ── removeFromWishlist ─────────────────────────────────────────────────────

  test(
    'removeFromWishlist: retorna Right cuando elimina correctamente',
    () async {
      when(
        () => localDataSource.removeCountry(
          countryCode: any(named: 'countryCode'),
        ),
      ).thenAnswer((_) async {});

      final result = await repository.removeFromWishlist(
        countryCode: 'FR',
      );

      expect(result.isRight(), isTrue);
    },
  );

  test(
    'removeFromWishlist: retorna DatabaseFailure cuando lanza SqliteException',
    () async {
      when(
        () => localDataSource.removeCountry(
          countryCode: any(named: 'countryCode'),
        ),
      ).thenThrow(SqliteException(1, 'delete failure'));

      final result = await repository.removeFromWishlist(
        countryCode: 'FR',
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<DatabaseFailure>()),
        (_) => fail('Se esperaba Failure'),
      );
    },
  );
}
