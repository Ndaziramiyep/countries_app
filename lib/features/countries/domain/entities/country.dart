import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String name;
  final String flag;
  final int population;
  final String cca2;
  final String? capital;
  final String? region;
  final String? subregion;
  final double? area;
  final List<String>? timezones;

  const Country({
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

  @override
  List<Object?> get props => [cca2];
}
