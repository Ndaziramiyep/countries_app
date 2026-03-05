import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';
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
  // Bloc
  sl.registerFactory(
    () => CountriesBloc(
      getAllCountries: sl(),
      searchCountries: sl(),
      getCountryDetails: sl(),
      manageFavorites: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllCountries(sl()));
  sl.registerLazySingleton(() => SearchCountries(sl()));
  sl.registerLazySingleton(() => GetCountryDetails(sl()));
  sl.registerLazySingleton(() => ManageFavorites(sl()));

  // Repository
  sl.registerLazySingleton<CountriesRepository>(
    () => CountriesRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<CountriesRemoteDataSource>(
    () => CountriesRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<CountriesLocalDataSource>(
    () => CountriesLocalDataSourceImpl(sl()),
  );

  // Core - Cache
  final cacheDir = await getTemporaryDirectory();
  final cacheStore = HiveCacheStore(cacheDir.path);
  final cacheOptions = CacheOptions(
    store: cacheStore,
    policy: CachePolicy.forceCache,
    maxStale: const Duration(days: 7),
    priority: CachePriority.high,
    hitCacheOnErrorExcept: [401, 403],
  );
  sl.registerLazySingleton(() => cacheOptions);
  sl.registerLazySingleton(() => DioClient(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
