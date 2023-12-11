import 'package:equatable/equatable.dart';
import 'package:mobile_assesment/weathers/domain/entity/favorite.dart';
import 'package:mobile_assesment/weathers/domain/entity/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

enum AuthStatus { loading, loaded, error }

class WeatherConditonState extends WeatherState {
  final AuthStatus status;
  final String? errorMessage;
  final Weather? weather;
  const WeatherConditonState({
    required this.status,
    this.errorMessage,
    this.weather,
  });

  @override
  List<Object> get props => [status];
}

class FavoriteState extends WeatherState {
  final AuthStatus status;
  final String? errorMessage;
  final Favorite? favorite;

  const FavoriteState({
    required this.status,
    this.errorMessage,
    this.favorite,
  });

  @override
  List<Object> get props => [status];
}

class InitializeFavoriteState extends WeatherState {
  final AuthStatus status;

  const InitializeFavoriteState({required this.status});

  @override
  List<Object> get props => [status];
}
