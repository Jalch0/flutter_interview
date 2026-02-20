// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryDetailModel _$CountryDetailModelFromJson(Map<String, dynamic> json) =>
    CountryDetailModel(
      cca2: json['cca2'] as String,
      name: CountryNameModel.fromJson(json['name'] as Map<String, dynamic>),
      flag: json['flag'] as String?,
      flags: CountryFlagsModel.fromJson(json['flags'] as Map<String, dynamic>),
      capital:
          (json['capital'] as List<dynamic>?)?.map((e) => e as String).toList(),
      population: (json['population'] as num).toInt(),
      region: json['region'] as String,
      subregion: json['subregion'] as String?,
      languages: json['languages'] as Map<String, dynamic>?,
      currencies: json['currencies'] as Map<String, dynamic>?,
      timezones: (json['timezones'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CountryDetailModelToJson(CountryDetailModel instance) =>
    <String, dynamic>{
      'cca2': instance.cca2,
      'name': instance.name,
      'flag': instance.flag,
      'flags': instance.flags,
      'capital': instance.capital,
      'population': instance.population,
      'region': instance.region,
      'subregion': instance.subregion,
      'languages': instance.languages,
      'currencies': instance.currencies,
      'timezones': instance.timezones,
    };
