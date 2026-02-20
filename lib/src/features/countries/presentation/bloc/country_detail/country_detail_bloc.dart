import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/country_detail.dart';
import '../../../domain/usecases/get_country_details.dart';

part 'country_detail_bloc.freezed.dart';
part 'country_detail_event.dart';
part 'country_detail_state.dart';

class CountryDetailBloc
    extends Bloc<CountryDetailEvent, CountryDetailState> {
  CountryDetailBloc({
    required GetCountryDetails getCountryDetails,
  })  : _getCountryDetails = getCountryDetails,
        super(const CountryDetailState.initial()) {
    on<_FetchRequested>(_onFetchRequested);
  }

  final GetCountryDetails _getCountryDetails;

  Future<void> _onFetchRequested(
    _FetchRequested event,
    Emitter<CountryDetailState> emit,
  ) async {
    emit(const CountryDetailState.loading());

    final result = await _getCountryDetails(
      GetCountryDetailsParams(countryName: event.countryName),
    );

    result.fold(
      (failure) => emit(
        CountryDetailState.error(message: failure.message),
      ),
      (countryDetail) => emit(
        CountryDetailState.loaded(countryDetail: countryDetail),
      ),
    );
  }
}
