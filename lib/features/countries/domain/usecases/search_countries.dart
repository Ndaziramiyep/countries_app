import 'package:dartz/dartz.dart';
import '../entities/country.dart';
import '../repositories/countries_repository.dart';
import '../../../../core/errors/failures.dart';

class SearchCountries {
  final CountriesRepository repository;

  SearchCountries(this.repository);

  Future<Either<Failure, List<Country>>> call(String name) async {
    return await repository.searchCountries(name);
  }
}
