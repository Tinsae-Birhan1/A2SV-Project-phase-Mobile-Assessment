import 'package:equatable/equatable.dart';

import '../../domain/entity/favorite.dart';

abstract class WeatherConditionEvent extends Equatable {
  const WeatherConditionEvent();

  @override
  List<Object> get props => [];
}

class WeatherEvent extends WeatherConditionEvent {
  // final UserCredential userCredential;
  final String search;
  // final String otp;

  const WeatherEvent({
    required this.search,
    // required this.otp,
  });

  @override
  List<Object> get props => [search];
}

class FavoriteEvent extends WeatherConditionEvent {
  final Favorite favorite;
  // final String otp;

  const FavoriteEvent({
    required this.favorite,
  });
  @override
  List<Object> get props => [favorite];
}

class InitializeFavoriteEvent extends WeatherConditionEvent {}
