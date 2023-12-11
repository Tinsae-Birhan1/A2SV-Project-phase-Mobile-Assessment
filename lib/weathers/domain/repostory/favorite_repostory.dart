import 'package:dartz/dartz.dart';
import 'package:mobile_assesment/weathers/domain/entity/favorite.dart';

import '../../../core/error/failure.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, Favorite>> getFavoriteWeather();
  Future<Either<Failure, void>> updateFavoriteWeather(
      {required Favorite favorite});
}
