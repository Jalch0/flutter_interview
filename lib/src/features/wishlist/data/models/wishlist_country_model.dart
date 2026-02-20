import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../countries/domain/entities/country.dart';
import '../db/app_database.dart';

class WishlistCountryModel {
  const WishlistCountryModel({
    required this.countryCode,
    required this.commonName,
    required this.officialName,
    required this.flagEmoji,
    required this.flagPng,
    required this.capital,
    required this.population,
    required this.region,
    required this.subregion,
  });

  factory WishlistCountryModel.fromEntity(Country entity) {
    return WishlistCountryModel(
      countryCode: entity.cca2,
      commonName: entity.commonName,
      officialName: entity.officialName,
      flagEmoji: entity.flagEmoji,
      flagPng: entity.flagPng,
      capital: entity.capital,
      population: entity.population,
      region: entity.region,
      subregion: entity.subregion,
    );
  }

  factory WishlistCountryModel.fromTableData(WishlistTableData data) {
    return WishlistCountryModel(
      countryCode: data.countryCode,
      commonName: data.commonName,
      officialName: data.officialName,
      flagEmoji: data.flagEmoji,
      flagPng: data.flagPng,
      capital: _decodeCapital(data.capitalsJson),
      population: data.population,
      region: data.region,
      subregion: data.subregion,
    );
  }

  final String countryCode;
  final String commonName;
  final String officialName;
  final String flagEmoji;
  final String flagPng;
  final List<String>? capital;
  final int population;
  final String region;
  final String subregion;

  WishlistTableCompanion toCompanion() {
    return WishlistTableCompanion(
      countryCode: Value(countryCode),
      commonName: Value(commonName),
      officialName: Value(officialName),
      flagEmoji: Value(flagEmoji),
      flagPng: Value(flagPng),
      capitalsJson: Value(_encodeCapital(capital)),
      population: Value(population),
      region: Value(region),
      subregion: Value(subregion),
    );
  }

  Country toEntity() {
    return Country(
      cca2: countryCode,
      commonName: commonName,
      officialName: officialName,
      flagEmoji: flagEmoji,
      flagPng: flagPng,
      capital: capital,
      population: population,
      region: region,
      subregion: subregion,
    );
  }

  static String? _encodeCapital(List<String>? capital) {
    if (capital == null) {
      return null;
    }

    return jsonEncode(capital);
  }

  static List<String>? _decodeCapital(String? rawCapital) {
    if (rawCapital == null || rawCapital.isEmpty) {
      return null;
    }

    final decoded = jsonDecode(rawCapital);

    if (decoded is! List) {
      return null;
    }

    return decoded.map((value) => value.toString()).toList(growable: false);
  }
}
