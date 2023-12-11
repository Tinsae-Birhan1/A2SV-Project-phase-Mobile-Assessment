import 'package:mobile_assesment/weathers/domain/entity/weather.dart';

class WeatherModel extends Weather {
  WeatherModel(
      {required super.observationTime,
      required super.query,
      required super.temperatureC,
      required super.windSpeedMiles,
      required super.humidity,
      required super.weatherIconUrl,
      required super.dailyWeather});
  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
      observationTime:
          json['current_condition'][0]['observation_time'] as String,
      query: json['request'][0]['query'] as String,
      temperatureC: json['current_condition'][0]['temp_C'] as String,
      weatherIconUrl:
          json['current_condition'][0]['weatherIconUrl'][0]['value'] as String,
      windSpeedMiles: json['current_condition'][0]['windspeedMiles'] as String,
      humidity: json['current_condition'][0]['humidity'] as String,
      dailyWeather: (json['weather'] as List)
          .map((daily) => DailyWeather.fromJson(daily))
          .toList());
}

class DailyWeather {
  final String date;
  final String maxTempC;
  final String minTempC;

  DailyWeather({
    required this.date,
    required this.maxTempC,
    required this.minTempC,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) => DailyWeather(
        date: json['date'] as String,
        maxTempC: json['maxtempC'] as String,
        minTempC: json['mintempC'] as String,
      );
}
