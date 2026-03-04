import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../di/service_locator.dart' as di;
import '../bloc/countries_bloc.dart';
import '../bloc/countries_event.dart';
import '../bloc/countries_state.dart';

class CountryDetailPage extends StatelessWidget {
  final String code;
  final String heroTag;

  const CountryDetailPage({super.key, required this.code, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<CountriesBloc>()..add(LoadCountryDetails(code)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Country Details'),
        ),
        body: BlocBuilder<CountriesBloc, CountriesState>(
          builder: (context, state) {
            if (state is CountriesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CountryDetailLoaded) {
              final country = state.country;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: heroTag,
                      child: Image.network(
                        country.flag,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  country.name,
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  state.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: state.isFavorite ? Colors.red : null,
                                ),
                                onPressed: () {
                                  context
                                      .read<CountriesBloc>()
                                      .add(ToggleFavoriteEvent(country.cca2));
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Key Statistics',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow('Area', '${country.area?.toStringAsFixed(0) ?? 'N/A'} sq km'),
                          _buildInfoRow('Population', '${(country.population / 1000000).toStringAsFixed(2)} million'),
                          if (country.region != null)
                            _buildInfoRow('Region', country.region!),
                          if (country.subregion != null)
                            _buildInfoRow('Sub Region', country.subregion!),
                          if (country.capital != null)
                            _buildInfoRow('Capital', country.capital!),
                          const SizedBox(height: 24),
                          if (country.timezones != null && country.timezones!.isNotEmpty) ...[
                            const Text(
                              'Timezone',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              children: country.timezones!
                                  .map((tz) => Chip(label: Text(tz)))
                                  .toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is CountriesError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
