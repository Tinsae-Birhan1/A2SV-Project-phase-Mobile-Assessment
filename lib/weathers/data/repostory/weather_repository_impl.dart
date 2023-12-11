import 'package:dartz/dartz.dart';
import 'package:mobile_assesment/weathers/data/datasource/datasources.dart';
import 'package:mobile_assesment/weathers/data/model/models.dart';
import 'package:mobile_assesment/weathers/domain/entity/weather.dart';
import 'package:mobile_assesment/weathers/domain/repostory/weather_repostory.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../core/network/network.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final FavoriteWeatherLocalDatasource localDatasource;
  final WeatherRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Weather>> getWeatherForCity({
    required String search,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final weatherModel = await remoteDatasource.getWeather(
          search: search,
        );

        // if (rememberMe) {
        //   await localDatasource.cacheWeatherCredential(
        //     userCredentialModel: userCredentialModel,
        //   );
        // }
        return Right(weatherModel);
      } on ServerException {
        return Left(ServerFailure());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
    return Left(NetworkFailure());
  }
}
