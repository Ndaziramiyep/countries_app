import 'package:dartz/dartz.dart';
import '../repositories/countries_repository.dart';
import '../../../../core/errors/failures.dart';

class ManageFavorites {
  final CountriesRepository repository;

  ManageFavorites(this.repository);

  Future<Either<Failure, List<String>>> getFavorites() async {
    return await repository.getFavorites();
  }

  Future<Either<Failure, void>> toggleFavorite(String cca2) async {
    return await repository.toggleFavorite(cca2);
  }
}
