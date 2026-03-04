import 'package:equatable/equatable.dart';
import '../../domain/entities/country.dart';

abstract class CountriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CountriesInitial extends CountriesState {}

class CountriesLoading extends CountriesState {}

class CountriesLoaded extends CountriesState {
  final List<Country> countries;
  final List<String> favorites;

  CountriesLoaded(this.countries, this.favorites);

  @override
  List<Object?> get props => [countries, favorites];
}

class CountryDetailLoaded extends CountriesState {
  final Country country;
  final bool isFavorite;

  CountryDetailLoaded(this.country, this.isFavorite);

  @override
  List<Object?> get props => [country, isFavorite];
}

class CountriesError extends CountriesState {
  final String message;

  CountriesError(this.message);

  @override
  List<Object?> get props => [message];
}
