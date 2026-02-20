// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
      cca2: json['cca2'] as String,
      name: CountryNameModel.fromJson(json['name'] as Map<String, dynamic>),
      flag: json['flag'] as String?,
      flags: CountryFlagsModel.fromJson(json['flags'] as Map<String, dynamic>),
      capital:
          (json['capital'] as List<dynamic>?)?.map((e) => e as String).toList(),
      population: (json['population'] as num).toInt(),
      region: json['region'] as String,
      subregion: json['subregion'] as String?,
    );

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'cca2': instance.cca2,
      'name': instance.name,
      'flag': instance.flag,
      'flags': instance.flags,
      'capital': instance.capital,
      'population': instance.population,
      'region': instance.region,
      'subregion': instance.subregion,
    };

CountryNameModel _$CountryNameModelFromJson(Map<String, dynamic> json) =>
    CountryNameModel(
      common: json['common'] as String,
      official: json['official'] as String,
    );

Map<String, dynamic> _$CountryNameModelToJson(CountryNameModel instance) =>
    <String, dynamic>{
      'common': instance.common,
      'official': instance.official,
    };

CountryFlagsModel _$CountryFlagsModelFromJson(Map<String, dynamic> json) =>
    CountryFlagsModel(
      png: json['png'] as String?,
    );

Map<String, dynamic> _$CountryFlagsModelToJson(CountryFlagsModel instance) =>
    <String, dynamic>{
      'png': instance.png,
    };
