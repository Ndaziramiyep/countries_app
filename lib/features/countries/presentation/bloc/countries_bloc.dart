import 'package:flutter_bloc/flutter_bloc.dart';
import 'countries_event.dart';
import 'countries_state.dart';
import '../../domain/entities/country.dart';
import '../../domain/usecases/get_all_countries.dart';
import '../../domain/usecases/search_countries.dart';
import '../../domain/usecases/get_country_details.dart';
import '../../domain/usecases/manage_favorites.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final GetAllCountries getAllCountries;
  final SearchCountries searchCountries;
  final GetCountryDetails getCountryDetails;
  final ManageFavorites manageFavorites;

  CountriesBloc({
    required this.getAllCountries,
    required this.searchCountries,
    required this.getCountryDetails,
    required this.manageFavorites,
  }) : super(CountriesInitial()) {
    on<LoadAllCountries>(_onLoadAllCountries);
    on<SearchCountriesEvent>(_onSearchCountries);
    on<LoadCountryDetails>(_onLoadCountryDetails);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<LoadFavorites>(_onLoadFavorites);
    on<SortCountries>(_onSortCountries);
  }

  Future<void> _onLoadAllCountries(
      LoadAllCountries event, Emitter<CountriesState> emit) async {
    emit(CountriesLoading());
    final result = await getAllCountries();
    final favoritesResult = await manageFavorites.getFavorites();

    result.fold(
      (failure) => emit(CountriesError('Failed to load countries')),
      (countries) => favoritesResult.fold(
        (failure) => emit(CountriesLoaded(countries, [])),
        (favorites) => emit(CountriesLoaded(countries, favorites)),
      ),
    );
  }

  Future<void> _onSearchCountries(
      SearchCountriesEvent event, Emitter<CountriesState> emit) async {
    if (event.query.isEmpty) {
      add(LoadAllCountries());
      return;
    }
    emit(CountriesLoading());
    final result = await searchCountries(event.query);
    final favoritesResult = await manageFavorites.getFavorites();

    result.fold(
      (failure) => emit(CountriesError('No countries found')),
      (countries) => favoritesResult.fold(
        (failure) => emit(CountriesLoaded(countries, [])),
        (favorites) => emit(CountriesLoaded(countries, favorites)),
      ),
    );
  }

  Future<void> _onLoadCountryDetails(
      LoadCountryDetails event, Emitter<CountriesState> emit) async {
    emit(CountriesLoading());
    final result = await getCountryDetails(event.code);
    final favoritesResult = await manageFavorites.getFavorites();

    result.fold(
      (failure) => emit(CountriesError('Failed to load country details')),
      (country) => favoritesResult.fold(
        (failure) => emit(CountryDetailLoaded(country, false)),
        (favorites) =>
            emit(CountryDetailLoaded(country, favorites.contains(country.cca2))),
      ),
    );
  }

  Future<void> _onToggleFavorite(
      ToggleFavoriteEvent event, Emitter<CountriesState> emit) async {
    await manageFavorites.toggleFavorite(event.cca2);
    if (state is CountryDetailLoaded) {
      final currentState = state as CountryDetailLoaded;
      emit(CountryDetailLoaded(currentState.country, !currentState.isFavorite));
    }
  }

  Future<void> _onLoadFavorites(
      LoadFavorites event, Emitter<CountriesState> emit) async {
    emit(CountriesLoading());
    final favoritesResult = await manageFavorites.getFavorites();
    final countriesResult = await getAllCountries();

    favoritesResult.fold(
      (failure) => emit(CountriesError('Failed to load favorites')),
      (favorites) => countriesResult.fold(
        (failure) => emit(CountriesError('Failed to load countries')),
        (countries) {
          final favoriteCountries =
              countries.where((c) => favorites.contains(c.cca2)).toList();
          emit(CountriesLoaded(favoriteCountries, favorites));
        },
      ),
    );
  }

  void _onSortCountries(SortCountries event, Emitter<CountriesState> emit) {
    if (state is CountriesLoaded) {
      final currentState = state as CountriesLoaded;
      final sortedCountries = List<Country>.from(currentState.countries);
      
      if (event.sortBy == 'name') {
        sortedCountries.sort((a, b) => a.name.compareTo(b.name));
      } else if (event.sortBy == 'population') {
        sortedCountries.sort((a, b) => b.population.compareTo(a.population));
      }
      
      emit(CountriesLoaded(sortedCountries, currentState.favorites));
    }
  }
}
