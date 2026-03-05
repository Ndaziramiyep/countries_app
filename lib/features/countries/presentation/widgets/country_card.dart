/// Country Card Widget
/// 
/// Displays country summary in a card format with flag, name, population.
/// Supports favorite toggle and navigation to details.
library;

import 'package:flutter/material.dart';
import '../../domain/entities/country.dart';

/// Reusable country card component
class CountryCard extends StatelessWidget {
  final Country country;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const CountryCard({
    super.key,
    required this.country,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  });

  /// Formats population with K/M suffixes
  String _formatPopulation(int population) {
    if (population >= 1000000) {
      return '${(population / 1000000).toStringAsFixed(2)}M';
    } else if (population >= 1000) {
      return '${(population / 1000).toStringAsFixed(2)}K';
    }
    return population.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        leading: Hero(
          tag: 'flag_${country.cca2}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              country.flag,
              width: 60,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.flag),
            ),
          ),
        ),
        title: Text(
          country.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Population: ${_formatPopulation(country.population)}'),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
          onPressed: onFavoriteTap,
        ),
      ),
    );
  }
}
