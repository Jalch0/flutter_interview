import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/usecases/use_case.dart';
import '../../../domain/entities/country.dart';
import '../../../domain/usecases/get_european_countries.dart';

part 'country_list_bloc.freezed.dart';
part 'country_list_event.dart';
part 'country_list_state.dart';

class CountryListBloc extends Bloc<CountryListEvent, CountryListState> {
  CountryListBloc({
    required GetEuropeanCountries getEuropeanCountries,
  })  : _getEuropeanCountries = getEuropeanCountries,
        super(const CountryListState.initial()) {
    on<_FetchRequested>(_onFetchRequested);
  }

  final GetEuropeanCountries _getEuropeanCountries;

  Future<void> _onFetchRequested(
    _FetchRequested event,
    Emitter<CountryListState> emit,
  ) async {
    emit(const CountryListState.loading());

    final result = await _getEuropeanCountries(const NoParams());

    result.fold(
      (failure) => emit(
        CountryListState.error(message: failure.message),
      ),
      (countries) => emit(
        CountryListState.loaded(countries: countries),
      ),
    );
  }
}
