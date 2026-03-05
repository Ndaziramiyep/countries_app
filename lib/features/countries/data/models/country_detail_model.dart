import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/country.dart';

part 'country_detail_model.freezed.dart';
part 'country_detail_model.g.dart';

@freezed
class CountryDetailModel with _$CountryDetailModel {
  const CountryDetailModel._();

  const factory CountryDetailModel({
    required String name,
    required String flag,
    required int population,
    required String cca2,
    String? capital,
    String? region,
    String? subregion,
    double? area,
    List<String>? timezones,
  }) = _CountryDetailModel;

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
