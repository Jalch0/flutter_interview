class CountryDetail {
  const CountryDetail({
    required this.cca2,
    required this.commonName,
    required this.officialName,
    required this.flagEmoji,
    required this.flagPng,
    required this.capital,
    required this.population,
    required this.region,
    required this.subregion,
    required this.languages,
    required this.currencies,
    required this.timezones,
  });

  final String cca2;
  final String commonName;
  final String officialName;
  final String flagEmoji;
  final String flagPng;
  final List<String>? capital;
  final int population;
  final String region;
  final String subregion;
  final List<String> languages;
  final List<String> currencies;
  final List<String> timezones;
}
