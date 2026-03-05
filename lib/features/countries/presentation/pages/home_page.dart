import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/countries_bloc.dart';
import '../bloc/countries_event.dart';
import '../bloc/countries_state.dart';
import '../widgets/country_card.dart';
import 'favorites_page.dart';
import 'country_detail_page.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const HomePage({super.key, required this.onThemeToggle});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _currentSort = 'none';

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<CountriesBloc>().add(SearchCountriesEvent(query));
    });
  }

  Future<void> _onRefresh() async {
    context.read<CountriesBloc>().add(LoadAllCountries());
    await Future.delayed(const Duration(seconds: 1));
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.sort_by_alpha),
            title: const Text('Sort by Name'),
            onTap: () {
              setState(() => _currentSort = 'name');
              context.read<CountriesBloc>().add(SortCountries('name'));
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Sort by Population'),
            onTap: () {
              setState(() => _currentSort = 'population');
              context.read<CountriesBloc>().add(SortCountries('population'));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _showSortOptions,
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onThemeToggle,
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search for a country',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<CountriesBloc, CountriesState>(
              builder: (context, state) {
                if (state is CountriesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CountriesLoaded) {
                  if (state.countries.isEmpty) {
                    return const Center(child: Text('No countries found'));
                  }
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isTablet = constraints.maxWidth > 600;
                        return GridView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isTablet ? 2 : 1,
                            childAspectRatio: isTablet ? 3 : 5,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemCount: state.countries.length,
                          itemBuilder: (context, index) {
                            final country = state.countries[index];
                            return CountryCard(
                              country: country,
                              isFavorite: state.favorites.contains(country.cca2),
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
                                context.read<CountriesBloc>().add(ToggleFavoriteEvent(country.cca2));
                              },
                            );
                          },
                        );
                      },
                    ),
                  );
                } else if (state is CountriesError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
