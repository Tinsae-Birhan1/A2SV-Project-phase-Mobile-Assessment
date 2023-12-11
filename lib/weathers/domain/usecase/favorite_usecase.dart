import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_assesment/core/usecase/usecase.dart';
import 'package:mobile_assesment/weathers/domain/entity/weather.dart';

import '../../../core/error/failure.dart';
import '../entity/favorite.dart';
import '../repostory/favorite_repostory.dart';
import '../repostory/weather_repostory.dart';

class FavoriteUsecase extends UseCase<void, FavoriteParams> {
  final FavoriteRepository repository;

  FavoriteUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(FavoriteParams params) async {
    final res =
        await repository.updateFavoriteWeather(favorite: params.favorite);

    return res;
  }
}

class FavoriteParams extends Equatable {
  // final UserCredential userCredential;
  final Favorite favorite;

  const FavoriteParams({
    required this.favorite,
  });

  @override
  List<Object?> get props => [];
}
