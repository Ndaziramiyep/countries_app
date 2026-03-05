import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_summary_model.freezed.dart';
part 'country_summary_model.g.dart';

@freezed
class CountrySummaryModel with _$CountrySummaryModel {
  const factory CountrySummaryModel({
    required String name,
    required String flag,
    required int population,
    required String cca2,
  }) = _CountrySummaryModel;

  factory CountrySummaryModel.fromJson(Map<String, dynamic> json) {
    return CountrySummaryModel(
      name: json['name']['common'] ?? '',
      flag: json['flags']['png'] ?? json['flags']['svg'] ?? '',
      population: json['population'] ?? 0,
      cca2: json['cca2'] ?? '',
    );
  }
}
