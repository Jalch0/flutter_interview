import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_interview/src/core/error/failures.dart';
import 'package:flutter_interview/src/core/usecases/use_case.dart';
import 'package:flutter_interview/src/features/countries/domain/entities/country.dart';
import 'package:flutter_interview/src/features/countries/domain/usecases/get_european_countries.dart';
import 'package:flutter_interview/src/features/countries/presentation/bloc/country_list/country_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetEuropeanCountries extends Mock
    implements GetEuropeanCountries {}

void main() {
  late MockGetEuropeanCountries mockGetEuropeanCountries;
  const country = Country(
    cca2: 'ES',
    commonName: 'Spain',
    officialName: 'Kingdom of Spain',
    flagEmoji: '🇪🇸',
    flagPng: 'https://flagcdn.com/w320/es.png',
    capital: ['Madrid'],
    population: 47351567,
    region: 'Europe',
    subregion: 'Southern Europe',
  );

  setUp(() {
    mockGetEuropeanCountries = MockGetEuropeanCountries();
  });

  blocTest<CountryListBloc, CountryListState>(
    'emite loading y loaded cuando fetch tiene éxito',
    build: () {
      when(
        () => mockGetEuropeanCountries(const NoParams()),
      ).thenAnswer((_) async => const Right([country]));

      return CountryListBloc(
        getEuropeanCountries: mockGetEuropeanCountries,
      );
    },
    act: (bloc) => bloc.add(const CountryListEvent.fetchRequested()),
    expect: () => const [
      CountryListState.loading(),
      CountryListState.loaded(countries: [country]),
    ],
    verify: (_) {
      verify(() => mockGetEuropeanCountries(const NoParams())).called(1);
    },
  );

  blocTest<CountryListBloc, CountryListState>(
    'emite loading y error cuando fetch falla',
    build: () {
      when(
        () => mockGetEuropeanCountries(const NoParams()),
      ).thenAnswer(
        (_) async => const Left(
          ServerFailure(message: 'Error de red'),
        ),
      );

      return CountryListBloc(
        getEuropeanCountries: mockGetEuropeanCountries,
      );
    },
    act: (bloc) => bloc.add(const CountryListEvent.fetchRequested()),
    expect: () => const [
      CountryListState.loading(),
      CountryListState.error(message: 'Error de red'),
    ],
    verify: (_) {
      verify(() => mockGetEuropeanCountries(const NoParams())).called(1);
    },
  );
}
