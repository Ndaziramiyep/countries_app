import 'package:dartz/dartz.dart';
import '../../domain/entities/country.dart';
import '../../domain/repositories/countries_repository.dart';
import '../datasources/countries_remote_datasource.dart';
import '../datasources/countries_local_datasource.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';

class CountriesRepositoryImpl implements CountriesRepository {
  final CountriesRemoteDataSource remoteDataSource;
  final CountriesLocalDataSource localDataSource;

  CountriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Country>>> getAllCountries() async {
    try {
      final summaries = await remoteDataSource.getAllCountries();
      return Right(summaries
          .map((s) => Country(
                name: s.name,
                flag: s.flag,
                population: s.population,
                cca2: s.cca2,
              ))
          .toList());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Country>>> searchCountries(String name) async {
    try {
      final summaries = await remoteDataSource.searchCountries(name);
      return Right(summaries
          .map((s) => Country(
                name: s.name,
                flag: s.flag,
                population: s.population,
                cca2: s.cca2,
              ))
          .toList());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Country>> getCountryDetails(String code) async {
    try {
      final detail = await remoteDataSource.getCountryDetails(code);
      return Right(detail.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getFavorites() async {
    try {
      final favorites = await localDataSource.getFavorites();
      return Right(favorites);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(String cca2) async {
    try {
      final favorites = await localDataSource.getFavorites();
      if (favorites.contains(cca2)) {
        await localDataSource.removeFavorite(cca2);
      } else {
        await localDataSource.addFavorite(cca2);
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
