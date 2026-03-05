/// Country Detail Data Model
/// 
/// Complete country information model for detail views.
/// Uses Freezed for immutability and includes domain entity conversion.
library;

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/country.dart';

part 'country_detail_model.freezed.dart';

/// Immutable country detail model with full information
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

  /// Creates model from REST Countries API response
  /// 
  /// Handles nested JSON structure, arrays, and type conversions
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

  /// Converts data model to domain entity
  /// 
  /// Separates data layer from domain layer for clean architecture
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
