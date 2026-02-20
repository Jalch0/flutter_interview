import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/country.dart';

part 'country_model.g.dart';

@JsonSerializable()
class CountryModel {
  const CountryModel({
    required this.cca2,
    required this.name,
    required this.flag,
    required this.flags,
    required this.capital,
    required this.population,
    required this.region,
    required this.subregion,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  final String cca2;
  final CountryNameModel name;
  final String? flag;
  final CountryFlagsModel flags;
  final List<String>? capital;
  final int population;
  final String region;
  final String? subregion;

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);

  Country toEntity() {
    return Country(
      cca2: cca2,
      commonName: name.common,
      officialName: name.official,
      flagEmoji: flag ?? '',
      flagPng: flags.png ?? '',
      capital: capital,
      population: population,
      region: region,
      subregion: subregion ?? '',
    );
  }
}

@JsonSerializable()
class CountryNameModel {
  const CountryNameModel({
    required this.common,
    required this.official,
  });

  factory CountryNameModel.fromJson(Map<String, dynamic> json) =>
      _$CountryNameModelFromJson(json);

  final String common;
  final String official;

  Map<String, dynamic> toJson() => _$CountryNameModelToJson(this);
}

@JsonSerializable()
class CountryFlagsModel {
  const CountryFlagsModel({
    required this.png,
  });

  factory CountryFlagsModel.fromJson(Map<String, dynamic> json) =>
      _$CountryFlagsModelFromJson(json);

  final String? png;

  Map<String, dynamic> toJson() => _$CountryFlagsModelToJson(this);
}
