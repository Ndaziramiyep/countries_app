import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/countries_bloc.dart';
import '../bloc/countries_event.dart';
import '../bloc/countries_state.dart';
import '../widgets/country_card.dart';
import 'country_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<CountriesBloc, CountriesState>(
        builder: (context, state) {
          if (state is CountriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CountriesLoaded) {
            final favoriteCountries = state.countries
                .where((c) => state.favorites.contains(c.cca2))
                .toList();

            if (favoriteCountries.isEmpty) {
              return const Center(
                child: Text('No favorite countries yet'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: favoriteCountries.length,
              itemBuilder: (context, index) {
                final country = favoriteCountries[index];
                return CountryCard(
                  country: country,
                  isFavorite: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CountryDetailPage(
                          code: country.cca2,
                          heroTag: 'flag_${country.cca2}',
                        ),
                      ),
                    );
                  },
                  onFavoriteTap: () {
                    context.read<CountriesBloc>().add(
                          ToggleFavoriteEvent(country.cca2),
                        );
                  },
                );
              },
            );
          } else if (state is CountriesError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
