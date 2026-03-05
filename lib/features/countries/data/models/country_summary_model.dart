/// Country Summary Data Model
/// 
/// Lightweight model for list views with essential country information.
/// Uses Freezed for immutability and code generation.
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_summary_model.freezed.dart';

/// Immutable country summary model
@freezed
class CountrySummaryModel with _$CountrySummaryModel {
  const factory CountrySummaryModel({
    required String name,
    required String flag,
    required int population,
    required String cca2,
  }) = _CountrySummaryModel;

  /// Creates model from REST Countries API response
  /// 
  /// Handles nested JSON structure and provides fallback values
  factory CountrySummaryModel.fromJson(Map<String, dynamic> json) {
    return CountrySummaryModel(
      name: json['name']['common'] ?? '',
      flag: json['flags']['png'] ?? json['flags']['svg'] ?? '',
      population: json['population'] ?? 0,
      cca2: json['cca2'] ?? '',
    );
  }
}
