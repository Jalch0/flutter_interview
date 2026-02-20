part of 'country_detail_bloc.dart';

@freezed
class CountryDetailEvent with _$CountryDetailEvent {
  const factory CountryDetailEvent.fetchRequested({
    required String countryName,
  }) = _FetchRequested;
}
