import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_assesment/weathers/data/model/models.dart';
import 'package:mobile_assesment/weathers/domain/entity/weather.dart';

import '../../../core/error/exception.dart';

abstract class WeatherRemoteDatasource {
  Future<Weather> getWeather({
    required String search,
  });
}

class WeatherRemoteDatasourceImpl extends WeatherRemoteDatasource {
  final http.Client client;

  WeatherRemoteDatasourceImpl({
    required this.client,
  });

  @override
  Future<Weather> getWeather({
    required String search,
  }) async {
    final response = await client.get(
      Uri.parse(
          "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=68da0c21ae6d455e91771733231110&q=${search}&num_of_days=7&tp=3&format=json"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body)['data'];
      if (responseJson['error'] == null) {
        return WeatherModel.fromJson(responseJson);
      }
    }
    throw ServerException();
  }
}
