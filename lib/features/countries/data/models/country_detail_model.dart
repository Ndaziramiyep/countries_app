import '../../domain/entities/country.dart';

class CountryDetailModel {
  final String name;
  final String flag;
  final int population;
  final String cca2;
  final String? capital;
  final String? region;
  final String? subregion;
  final double? area;
  final List<String>? timezones;

  CountryDetailModel({
    required this.name,
    required this.flag,
    required this.population,
    required this.cca2,
    this.capital,
    this.region,
    this.subregion,
    this.area,
    this.timezones,
  });

  factory CountryDetailModel.fromJson(Map<String, dynamic> json) {
    return CountryDetailModel(
      name: json['name']['common'] ?? '',
      flag: json['flags']['png'] ?? json['flags']['svg'] ?? '',
      population: json['population'] ?? 0,
      cca2: json['cca2'] ?? '',
      capital: json['capital'] != null && (json['capital'] as List).isNotEmpty
          ? json['capital'][0]
          : null,
      region: json['region'],
      subregion: json['subregion'],
      area: json['area']?.toDouble(),
      timezones: json['timezones'] != null
          ? List<String>.from(json['timezones'])
          : null,
    );
  }

  Country toEntity() {
    return Country(
      name: name,
      flag: flag,
      population: population,
      cca2: cca2,
      capital: capital,
      region: region,
      subregion: subregion,
      area: area,
      timezones: timezones,
    );
  }
}
