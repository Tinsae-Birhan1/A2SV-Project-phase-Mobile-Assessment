import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assesment/weathers/domain/entity/favorite.dart';
import 'package:mobile_assesment/weathers/domain/usecase/favorite_usecase.dart';
import 'package:mobile_assesment/weathers/domain/usecase/initailize_favorite_usecase.dart';
import 'package:mobile_assesment/weathers/presentation/bloc/weather_state.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../domain/entity/weather.dart';
import '../../domain/usecase/weather_usecase.dart';
import 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherConditionEvent, WeatherState> {
  final WeatherUsecase weatherUsecase;
  final FavoriteUsecase favoriteUsecase;
  final InitailizedFavoriteUsecase initializeFavoriteUsecase;

  WeatherBloc({
    required this.weatherUsecase,
    required this.favoriteUsecase,
    required this.initializeFavoriteUsecase,
  }) : super(WeatherInitial()) {
    on<WeatherEvent>(_onWeatherup);
    on<FavoriteEvent>(_onFavoriteup);
    on<InitializeFavoriteEvent>(_onInitializeApp);
  }

  void _onWeatherup(WeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherConditonState(status: AuthStatus.loading));
    final failureOrSignup = await weatherUsecase(
      WeatherParams(
        search: event.search,
        // otp: event.otp,
      ),
    );

    emit(_eitherSignupOrFailure(failureOrSignup));
  }

  WeatherConditonState _eitherSignupOrFailure(
      Either<Failure, Weather> failureOrSignup) {
    final res = failureOrSignup.fold(
        (l) => WeatherConditonState(
              status: AuthStatus.error,
              errorMessage: " _mapLoginFailureToMessage(l)",
            ),
        (r) => WeatherConditonState(
              status: AuthStatus.loaded,
              weather: r,
            ));

    return res;
  }

  void _onFavoriteup(FavoriteEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherConditonState(status: AuthStatus.loading));
    final failureOrSignup = await favoriteUsecase(
      FavoriteParams(favorite: event.favorite),
    );

    emit(_eitherFavoriteOrFailure(failureOrSignup));
  }

  FavoriteState _eitherFavoriteOrFailure(
      Either<Failure, void> failureOrSignup) {
    final res = failureOrSignup.fold(
        (l) => FavoriteState(
              status: AuthStatus.error,
              errorMessage: "No city found",
            ),
        (r) => FavoriteState(
              status: AuthStatus.loaded,
            ));

    return res;
  }

  void _onInitializeApp(
      InitializeFavoriteEvent event, Emitter<WeatherState> emit) async {
    emit(const InitializeFavoriteState(status: AuthStatus.loading));
    final failureOrInitializeApp = await initializeFavoriteUsecase(NoParams());
    emit(_eitherInitializeAppOrError(failureOrInitializeApp));
  }

  FavoriteState _eitherInitializeAppOrError(
      Either<Failure, Favorite> failureOrInitializeApp) {
    return failureOrInitializeApp.fold(
        (l) => FavoriteState(
              status: AuthStatus.error,
              errorMessage: "No Favorite found",
            ),
        (r) => FavoriteState(
              status: AuthStatus.loaded,
              favorite: r,
            ));
  }
}
