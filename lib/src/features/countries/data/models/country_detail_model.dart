import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/country_detail.dart';
import 'country_model.dart';

part 'country_detail_model.g.dart';

@JsonSerializable()
class CountryDetailModel {
  const CountryDetailModel({
    required this.cca2,
    required this.name,
    required this.flag,
    required this.flags,
    required this.capital,
    required this.population,
    required this.region,
    required this.subregion,
    required this.languages,
    required this.currencies,
    required this.timezones,
  });

  factory CountryDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CountryDetailModelFromJson(json);

  final String cca2;
  final CountryNameModel name;
  final String? flag;
  final CountryFlagsModel flags;
  final List<String>? capital;
  final int population;
  final String region;
  final String? subregion;
  final Map<String, dynamic>? languages;
  final Map<String, dynamic>? currencies;
  final List<String>? timezones;

  Map<String, dynamic> toJson() => _$CountryDetailModelToJson(this);

  CountryDetail toEntity() {
    return CountryDetail(
      cca2: cca2,
      commonName: name.common,
      officialName: name.official,
      flagEmoji: flag ?? '',
      flagPng: flags.png ?? '',
      capital: capital,
      population: population,
      region: region,
      subregion: subregion ?? '',
      languages: _parseLanguages(languages),
      currencies: _parseCurrencies(currencies),
      timezones: timezones ?? const [],
    );
  }

  List<String> _parseLanguages(Map<String, dynamic>? rawLanguages) {
    if (rawLanguages == null || rawLanguages.isEmpty) {
      return const [];
    }

    return rawLanguages.values
        .map((value) => value.toString())
        .toList(growable: false);
  }

  List<String> _parseCurrencies(Map<String, dynamic>? rawCurrencies) {
    if (rawCurrencies == null || rawCurrencies.isEmpty) {
      return const [];
    }

    return rawCurrencies.values
        .map((value) {
          if (value is Map<String, dynamic>) {
            return value['name']?.toString() ?? '';
          }

          return '';
        })
        .where((value) => value.isNotEmpty)
        .toList(growable: false);
  }
}
