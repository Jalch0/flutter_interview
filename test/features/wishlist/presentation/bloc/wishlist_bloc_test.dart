import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_interview/src/core/error/failures.dart';
import 'package:flutter_interview/src/core/usecases/use_case.dart';
import 'package:flutter_interview/src/features/countries/domain/entities/country.dart';
import 'package:flutter_interview/src/features/wishlist/domain/usecases/get_wishlist.dart';
import 'package:flutter_interview/src/features/wishlist/domain/usecases/remove_from_wishlist.dart';
import 'package:flutter_interview/src/features/wishlist/domain/usecases/save_to_wishlist.dart';
import 'package:flutter_interview/src/features/wishlist/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetWishlist extends Mock implements GetWishlist {}

class MockSaveToWishlist extends Mock implements SaveToWishlist {}

class MockRemoveFromWishlist extends Mock implements RemoveFromWishlist {}

class FakeNoParams extends Fake implements NoParams {}

class FakeSaveToWishlistParams extends Fake
    implements SaveToWishlistParams {}

class FakeRemoveFromWishlistParams extends Fake
    implements RemoveFromWishlistParams {}

Future<void> _noOpSimulation({
  required String countryCode,
  required String countryName,
}) async {}

void main() {
  late MockGetWishlist mockGetWishlist;
  late MockSaveToWishlist mockSaveToWishlist;
  late MockRemoveFromWishlist mockRemoveFromWishlist;

  const country = Country(
    cca2: 'PT',
    commonName: 'Portugal',
    officialName: 'Portuguese Republic',
    flagEmoji: '🇵🇹',
    flagPng: 'https://flagcdn.com/w320/pt.png',
    capital: ['Lisbon'],
    population: 10305564,
    region: 'Europe',
    subregion: 'Southern Europe',
  );

  WishlistBloc buildBloc() => WishlistBloc(
        getWishlist: mockGetWishlist,
        saveToWishlist: mockSaveToWishlist,
        removeFromWishlist: mockRemoveFromWishlist,
        heavySimulation: _noOpSimulation,
      );

  setUpAll(() {
    registerFallbackValue(FakeNoParams());
    registerFallbackValue(FakeSaveToWishlistParams());
    registerFallbackValue(FakeRemoveFromWishlistParams());
  });

  setUp(() {
    mockGetWishlist = MockGetWishlist();
    mockSaveToWishlist = MockSaveToWishlist();
    mockRemoveFromWishlist = MockRemoveFromWishlist();
  });

  // ── loadRequested ──────────────────────────────────────────────────────────

  blocTest<WishlistBloc, WishlistState>(
    'loadRequested: emite loading y loaded cuando carga wishlist con éxito',
    build: () {
      when(
        () => mockGetWishlist(any()),
      ).thenAnswer((_) async => const Right([country]));

      return buildBloc();
    },
    act: (bloc) => bloc.add(const WishlistEvent.loadRequested()),
    expect: () => const [
      WishlistState.loading(),
      WishlistState.loaded(countries: [country]),
    ],
    verify: (_) {
      verify(() => mockGetWishlist(any())).called(1);
    },
  );

  blocTest<WishlistBloc, WishlistState>(
    'loadRequested: emite loading y error cuando cargar wishlist falla',
    build: () {
      when(
        () => mockGetWishlist(any()),
      ).thenAnswer(
        (_) async => const Left(
          DatabaseFailure(message: 'DB error'),
        ),
      );

      return buildBloc();
    },
    act: (bloc) => bloc.add(const WishlistEvent.loadRequested()),
    expect: () => const [
      WishlistState.loading(),
      WishlistState.error(message: 'DB error'),
    ],
  );

  // ── addRequested ───────────────────────────────────────────────────────────

  blocTest<WishlistBloc, WishlistState>(
    'addRequested: emite loading y saved cuando agregar favorito funciona',
    build: () {
      when(
        () => mockSaveToWishlist(any()),
      ).thenAnswer((_) async => const Right(null));
      when(
        () => mockGetWishlist(any()),
      ).thenAnswer((_) async => const Right([country]));

      return buildBloc();
    },
    act: (bloc) => bloc.add(
      const WishlistEvent.addRequested(country: country),
    ),
    expect: () => const [
      WishlistState.loading(),
      WishlistState.saved(countries: [country]),
    ],
    verify: (_) {
      verify(() => mockSaveToWishlist(any())).called(1);
      verify(() => mockGetWishlist(any())).called(1);
    },
  );

  blocTest<WishlistBloc, WishlistState>(
    'addRequested: emite loading y error cuando guardar falla',
    build: () {
      when(
        () => mockSaveToWishlist(any()),
      ).thenAnswer(
        (_) async => const Left(
          DatabaseFailure(message: 'Error al guardar'),
        ),
      );

      return buildBloc();
    },
    act: (bloc) => bloc.add(
      const WishlistEvent.addRequested(country: country),
    ),
    expect: () => const [
      WishlistState.loading(),
      WishlistState.error(message: 'Error al guardar'),
    ],
    verify: (_) {
      verify(() => mockSaveToWishlist(any())).called(1);
      verifyNever(() => mockGetWishlist(any()));
    },
  );

  // ── removeRequested ────────────────────────────────────────────────────────

  blocTest<WishlistBloc, WishlistState>(
    'removeRequested: emite loading y loaded cuando eliminar funciona',
    build: () {
      when(
        () => mockRemoveFromWishlist(any()),
      ).thenAnswer((_) async => const Right(null));
      when(
        () => mockGetWishlist(any()),
      ).thenAnswer((_) async => const Right([]));

      return buildBloc();
    },
    act: (bloc) => bloc.add(
      const WishlistEvent.removeRequested(countryCode: 'PT'),
    ),
    expect: () => const [
      WishlistState.loading(),
      WishlistState.loaded(countries: []),
    ],
    verify: (_) {
      verify(() => mockRemoveFromWishlist(any())).called(1);
      verify(() => mockGetWishlist(any())).called(1);
    },
  );

  blocTest<WishlistBloc, WishlistState>(
    'removeRequested: emite loading y error cuando eliminar falla',
    build: () {
      when(
        () => mockRemoveFromWishlist(any()),
      ).thenAnswer(
        (_) async => const Left(
          DatabaseFailure(message: 'Error al eliminar'),
        ),
      );

      return buildBloc();
    },
    act: (bloc) => bloc.add(
      const WishlistEvent.removeRequested(countryCode: 'PT'),
    ),
    expect: () => const [
      WishlistState.loading(),
      WishlistState.error(message: 'Error al eliminar'),
    ],
    verify: (_) {
      verify(() => mockRemoveFromWishlist(any())).called(1);
      verifyNever(() => mockGetWishlist(any()));
    },
  );
}
