import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get_it/get_it.dart';

import '../../features/countries/data/datasources/countries_remote_data_source.dart';
import '../../features/countries/data/repositories/country_repository_impl.dart';
import '../../features/countries/domain/repositories/country_repository.dart';
import '../../features/countries/domain/usecases/get_country_details.dart';
import '../../features/countries/domain/usecases/get_european_countries.dart';
import '../../features/countries/presentation/bloc/country_detail/country_detail_bloc.dart';
import '../../features/countries/presentation/bloc/country_list/country_list_bloc.dart';
import '../../features/wishlist/data/datasources/wishlist_local_data_source.dart';
import '../../features/wishlist/data/db/app_database.dart';
import '../../features/wishlist/data/db/wishlist_dao.dart';
import '../../features/wishlist/data/repositories/wishlist_repository_impl.dart';
import '../../features/wishlist/domain/repositories/wishlist_repository.dart';
import '../../features/wishlist/domain/usecases/get_wishlist.dart';
import '../../features/wishlist/domain/usecases/remove_from_wishlist.dart';
import '../../features/wishlist/domain/usecases/save_to_wishlist.dart';
import '../../features/wishlist/presentation/bloc/wishlist/wishlist_bloc.dart';
import '../network/rest_countries_dio.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  if (getIt.isRegistered<Dio>()) {
    return;
  }

  getIt.registerLazySingleton<CacheStore>(() => MemCacheStore());

  getIt.registerLazySingleton<CacheOptions>(
    () => RestCountriesDio.buildCacheOptions(
      cacheStore: getIt<CacheStore>(),
    ),
  );

  getIt.registerLazySingleton<Dio>(
    () => RestCountriesDio.buildDio(
      cacheOptions: getIt<CacheOptions>(),
    ),
  );

  getIt.registerLazySingleton<CountriesRemoteDataSource>(
    () => CountriesRemoteDataSourceImpl(
      dio: getIt<Dio>(),
      cacheOptions: getIt<CacheOptions>(),
    ),
  );

  getIt.registerLazySingleton<CountryRepository>(
    () => CountryRepositoryImpl(
      remoteDataSource: getIt<CountriesRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetEuropeanCountries>(
    () => GetEuropeanCountries(getIt<CountryRepository>()),
  );

  getIt.registerLazySingleton<GetCountryDetails>(
    () => GetCountryDetails(getIt<CountryRepository>()),
  );

  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  getIt.registerLazySingleton<WishlistDao>(
    () => getIt<AppDatabase>().wishlistDao,
  );

  getIt.registerLazySingleton<WishlistLocalDataSource>(
    () => WishlistLocalDataSourceImpl(
      wishlistDao: getIt<WishlistDao>(),
    ),
  );

  getIt.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(
      localDataSource: getIt<WishlistLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<SaveToWishlist>(
    () => SaveToWishlist(getIt<WishlistRepository>()),
  );

  getIt.registerLazySingleton<GetWishlist>(
    () => GetWishlist(getIt<WishlistRepository>()),
  );

  getIt.registerLazySingleton<RemoveFromWishlist>(
    () => RemoveFromWishlist(getIt<WishlistRepository>()),
  );

  getIt.registerFactory<CountryListBloc>(
    () => CountryListBloc(
      getEuropeanCountries: getIt<GetEuropeanCountries>(),
    ),
  );

  getIt.registerFactory<CountryDetailBloc>(
    () => CountryDetailBloc(
      getCountryDetails: getIt<GetCountryDetails>(),
    ),
  );

  getIt.registerFactory<WishlistBloc>(
    () => WishlistBloc(
      getWishlist: getIt<GetWishlist>(),
      saveToWishlist: getIt<SaveToWishlist>(),
      removeFromWishlist: getIt<RemoveFromWishlist>(),
    ),
  );
}
