import 'package:dartz/dartz.dart';
import '../../domain/entities/country.dart';
import '../../../../core/errors/failures.dart';

abstract class CountriesRepository {
  Future<Either<Failure, List<Country>>> getAllCountries();
  Future<Either<Failure, List<Country>>> searchCountries(String name);
  Future<Either<Failure, Country>> getCountryDetails(String code);
  Future<Either<Failure, List<String>>> getFavorites();
  Future<Either<Failure, void>> toggleFavorite(String cca2);
}
