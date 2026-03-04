import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

abstract class CountriesLocalDataSource {
  Future<List<String>> getFavorites();
  Future<void> addFavorite(String cca2);
  Future<void> removeFavorite(String cca2);
}

class CountriesLocalDataSourceImpl implements CountriesLocalDataSource {
  final SharedPreferences prefs;
  static const String favoritesKey = 'favorites';

  CountriesLocalDataSourceImpl(this.prefs);

  @override
  Future<List<String>> getFavorites() async {
    final favorites = prefs.getStringList(favoritesKey);
    return favorites ?? [];
  }

  @override
  Future<void> addFavorite(String cca2) async {
    final favorites = await getFavorites();
    if (!favorites.contains(cca2)) {
      favorites.add(cca2);
      await prefs.setStringList(favoritesKey, favorites);
    }
  }

  @override
  Future<void> removeFavorite(String cca2) async {
    final favorites = await getFavorites();
    favorites.remove(cca2);
    await prefs.setStringList(favoritesKey, favorites);
  }
}
