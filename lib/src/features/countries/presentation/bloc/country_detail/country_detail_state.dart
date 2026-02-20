part of 'country_detail_bloc.dart';

@freezed
class CountryDetailState with _$CountryDetailState {
  const factory CountryDetailState.initial() = _Initial;

  const factory CountryDetailState.loading() = _Loading;

  const factory CountryDetailState.loaded({
    required CountryDetail countryDetail,
  }) = _Loaded;

  const factory CountryDetailState.error({
    required String message,
  }) = _Error;
}
