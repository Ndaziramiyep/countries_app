class CountrySummaryModel {
  final String name;
  final String flag;
  final int population;
  final String cca2;

  CountrySummaryModel({
    required this.name,
    required this.flag,
    required this.population,
    required this.cca2,
  });

  factory CountrySummaryModel.fromJson(Map<String, dynamic> json) {
    return CountrySummaryModel(
      name: json['name']['common'] ?? '',
      flag: json['flags']['png'] ?? json['flags']['svg'] ?? '',
      population: json['population'] ?? 0,
      cca2: json['cca2'] ?? '',
    );
  }
}
