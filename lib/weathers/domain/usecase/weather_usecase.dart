import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_assesment/core/usecase/usecase.dart';
import 'package:mobile_assesment/weathers/domain/entity/weather.dart';

import '../../../core/error/failure.dart';
import '../repostory/weather_repostory.dart';

class WeatherUsecase extends UseCase<Weather, WeatherParams> {
  final WeatherRepository repository;

  WeatherUsecase({required this.repository});

  @override
  Future<Either<Failure, Weather>> call(WeatherParams params) async {
    return await repository.getWeatherForCity(
      search: params.search,
    );
  }
}

class WeatherParams extends Equatable {
  // final UserCredential userCredential;
  final String search;

  const WeatherParams({
    required this.search,
  });

  @override
  List<Object?> get props => [search];
}
