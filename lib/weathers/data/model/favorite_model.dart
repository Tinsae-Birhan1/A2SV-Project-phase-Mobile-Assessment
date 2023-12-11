import 'package:mobile_assesment/weathers/domain/entity/favorite.dart';
import 'package:mobile_assesment/weathers/domain/entity/weather.dart';

class FavoriteModel extends Favorite {
  FavoriteModel(
      {required super.query,
      required super.temperatureC,
      required super.weatherIconUrl});

  factory FavoriteModel.fromLocalCachedJson(Map<String, dynamic> json) {
    return FavoriteModel(
      query: json['query'] ?? '',
      temperatureC: json['temperatureC'] ?? '',
      weatherIconUrl: json['weatherIconUrl'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'temperatureC': temperatureC,
      'weatherIconUrl': weatherIconUrl
    };
  }
}
