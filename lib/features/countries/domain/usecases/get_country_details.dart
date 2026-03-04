import 'package:dartz/dartz.dart';
import '../entities/country.dart';
import '../repositories/countries_repository.dart';
import '../../../../core/errors/failures.dart';

class GetCountryDetails {
  final CountriesRepository repository;

  GetCountryDetails(this.repository);

  Future<Either<Failure, Country>> call(String code) async {
    return await repository.getCountryDetails(code);
  }
}
