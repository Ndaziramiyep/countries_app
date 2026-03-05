import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import '../core/network/dio_client.dart';
import '../features/countries/data/datasources/countries_remote_datasource.dart';
import '../features/countries/data/datasources/countries_local_datasource.dart';
import '../features/countries/data/repositories/countries_repository_impl.dart';
import '../features/countries/domain/repositories/countries_repository.dart';
import '../features/countries/domain/usecases/get_all_countries.dart';
import '../features/countries/domain/usecases/search_countries.dart';
import '../features/countries/domain/usecases/get_country_details.dart';
import '../features/countries/domain/usecases/manage_favorites.dart';
import '../features/countries/presentation/bloc/countries_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External Dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Core Layer - Simple memory cache
  final cacheOptions = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.request,
    maxStale: const Duration(days: 7),
    priority: CachePriority.normal,
  );
  sl.registerLazySingleton(() => cacheOptions);
  sl.registerLazySingleton(() => DioClient(sl()));

  // Data Layer
  sl.registerLazySingleton<CountriesLocalDataSource>(
    () => CountriesLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<CountriesRemoteDataSource>(
    () => CountriesRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<CountriesRepository>(
    () => CountriesRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Domain Layer
  sl.registerLazySingleton(() => GetAllCountries(sl()));
  sl.registerLazySingleton(() => SearchCountries(sl()));
  sl.registerLazySingleton(() => GetCountryDetails(sl()));
  sl.registerLazySingleton(() => ManageFavorites(sl()));

  // Presentation Layer
  sl.registerFactory(
    () => CountriesBloc(
      getAllCountries: sl(),
      searchCountries: sl(),
      getCountryDetails: sl(),
      manageFavorites: sl(),
    ),
  );
}
