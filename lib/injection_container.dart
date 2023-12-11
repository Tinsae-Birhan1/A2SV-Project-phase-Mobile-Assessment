import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_assesment/weathers/data/datasource/favorite_weather_local_datasource.dart';
import 'package:mobile_assesment/weathers/domain/usecase/favorite_usecase.dart';
import 'package:mobile_assesment/weathers/domain/usecase/initailize_favorite_usecase.dart';

import 'core/network/network.dart';
import 'weathers/data/datasource/weather_remote_datasource.dart';
import 'weathers/data/repostory/favorite_repostory.dart';
import 'weathers/data/repostory/weather_repository_impl.dart';
import 'weathers/domain/repostory/favorite_repostory.dart';
import 'weathers/domain/repostory/weather_repostory.dart';
import 'weathers/domain/usecase/weather_usecase.dart';
import 'weathers/presentation/bloc/weather_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Features
  //! Feature_#1 Authentication ----------------------------

  // Bloc

  serviceLocator.registerFactory(
    () => WeatherBloc(
        weatherUsecase: serviceLocator(),
        favoriteUsecase: serviceLocator(),
        initializeFavoriteUsecase: serviceLocator()),
  );

  // Usecase
  serviceLocator.registerLazySingleton(
      () => WeatherUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => FavoriteUsecase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => InitailizedFavoriteUsecase(repository: serviceLocator()));
  // Repository
  serviceLocator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDatasource: serviceLocator(),
      localDatasource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(
      localDatasource: serviceLocator(),
    ),
  );
  // DataSource
  serviceLocator.registerLazySingleton<FavoriteWeatherLocalDatasource>(
    () => FavoriteWeatherLocalDatasourceImpl(
      flutterSecureStorage: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<WeatherRemoteDatasource>(
    () => WeatherRemoteDatasourceImpl(
      client: serviceLocator(),
    ),
  );

  //! Core ----------------------------------
  serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        internetConnectionChecker: serviceLocator(),
      ));

  //! External-----------------------------------
  const flutterSecureStorage = FlutterSecureStorage();
  serviceLocator.registerFactory(() => flutterSecureStorage);

  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
}
