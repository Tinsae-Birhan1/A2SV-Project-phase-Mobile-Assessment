import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../data/repostory/weather_repository_impl.dart';
import '../entity/weather.dart';
import '../usecase/weather_usecase.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getWeatherForCity({required String search});
}
