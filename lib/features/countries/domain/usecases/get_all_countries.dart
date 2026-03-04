import 'package:dartz/dartz.dart';
import '../entities/country.dart';
import '../repositories/countries_repository.dart';
import '../../../../core/errors/failures.dart';

class GetAllCountries {
  final CountriesRepository repository;

  GetAllCountries(this.repository);

  Future<Either<Failure, List<Country>>> call() async {
    return await repository.getAllCountries();
  }
}
