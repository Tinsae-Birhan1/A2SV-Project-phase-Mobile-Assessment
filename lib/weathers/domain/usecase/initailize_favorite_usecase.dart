import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_assesment/core/usecase/usecase.dart';
import 'package:mobile_assesment/weathers/domain/entity/weather.dart';

import '../../../core/error/failure.dart';
import '../entity/favorite.dart';
import '../repostory/favorite_repostory.dart';
import '../repostory/weather_repostory.dart';

class InitailizedFavoriteUsecase extends UseCase<Favorite, NoParams> {
  final FavoriteRepository repository;

  InitailizedFavoriteUsecase({required this.repository});

  @override
  Future<Either<Failure, Favorite>> call(NoParams params) async {
    final res = await repository.getFavoriteWeather();

    return res;
  }
}
