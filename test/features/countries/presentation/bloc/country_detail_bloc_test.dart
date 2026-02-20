import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_interview/src/core/error/failures.dart';
import 'package:flutter_interview/src/features/countries/domain/entities/country_detail.dart';
import 'package:flutter_interview/src/features/countries/domain/usecases/get_country_details.dart';
import 'package:flutter_interview/src/features/countries/presentation/bloc/country_detail/country_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCountryDetails extends Mock implements GetCountryDetails {}

class FakeGetCountryDetailsParams extends Fake
    implements GetCountryDetailsParams {}

void main() {
  late MockGetCountryDetails mockGetCountryDetails;

  const countryDetail = CountryDetail(
    cca2: 'ES',
    commonName: 'Spain',
    officialName: 'Kingdom of Spain',
    flagEmoji: '🇪🇸',
    flagPng: 'https://flagcdn.com/w320/es.png',
    capital: ['Madrid'],
    population: 47351567,
    region: 'Europe',
    subregion: 'Southern Europe',
    languages: ['Spanish'],
    currencies: ['Euro'],
    timezones: ['UTC+01:00'],
  );

  setUpAll(() {
    registerFallbackValue(FakeGetCountryDetailsParams());
  });

  setUp(() {
    mockGetCountryDetails = MockGetCountryDetails();
  });

  blocTest<CountryDetailBloc, CountryDetailState>(
    'emite loading y loaded cuando fetch tiene éxito',
    build: () {
      when(
        () => mockGetCountryDetails(any()),
      ).thenAnswer((_) async => const Right(countryDetail));

      return CountryDetailBloc(
        getCountryDetails: mockGetCountryDetails,
      );
    },
    act: (bloc) => bloc.add(
      const CountryDetailEvent.fetchRequested(countryName: 'Spain'),
    ),
    expect: () => const [
      CountryDetailState.loading(),
      CountryDetailState.loaded(countryDetail: countryDetail),
    ],
    verify: (_) {
      verify(() => mockGetCountryDetails(any())).called(1);
    },
  );

  blocTest<CountryDetailBloc, CountryDetailState>(
    'emite loading y error cuando fetch falla',
    build: () {
      when(
        () => mockGetCountryDetails(any()),
      ).thenAnswer(
        (_) async => const Left(
          ServerFailure(message: 'País no encontrado'),
        ),
      );

      return CountryDetailBloc(
        getCountryDetails: mockGetCountryDetails,
      );
    },
    act: (bloc) => bloc.add(
      const CountryDetailEvent.fetchRequested(countryName: 'Unknown'),
    ),
    expect: () => const [
      CountryDetailState.loading(),
      CountryDetailState.error(message: 'País no encontrado'),
    ],
    verify: (_) {
      verify(() => mockGetCountryDetails(any())).called(1);
    },
  );
}
