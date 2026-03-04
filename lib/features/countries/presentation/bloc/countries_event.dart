import 'package:equatable/equatable.dart';

abstract class CountriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAllCountries extends CountriesEvent {}

class SearchCountriesEvent extends CountriesEvent {
  final String query;
  SearchCountriesEvent(this.query);
  @override
  List<Object?> get props => [query];
}

class LoadCountryDetails extends CountriesEvent {
  final String code;
  LoadCountryDetails(this.code);
  @override
  List<Object?> get props => [code];
}

class ToggleFavoriteEvent extends CountriesEvent {
  final String cca2;
  ToggleFavoriteEvent(this.cca2);
  @override
  List<Object?> get props => [cca2];
}

class LoadFavorites extends CountriesEvent {}

class SortCountries extends CountriesEvent {
  final String sortBy;
  SortCountries(this.sortBy);
  @override
  List<Object?> get props => [sortBy];
}
