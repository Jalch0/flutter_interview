class Country {
  const Country({
    required this.cca2,
    required this.commonName,
    required this.officialName,
    required this.flagEmoji,
    required this.flagPng,
    required this.capital,
    required this.population,
    required this.region,
    required this.subregion,
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
}
