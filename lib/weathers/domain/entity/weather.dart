// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:mobile_assesment/weathers/data/model/models.dart';

class Weather extends Equatable {
  final String observationTime;
  final String query;
  final String temperatureC;
  final String windSpeedMiles;
  final String humidity;
  final String weatherIconUrl;

  final List<DailyWeather> dailyWeather;

  Weather(
      {required this.observationTime,
      required this.query,
      required this.temperatureC,
      required this.windSpeedMiles,
      required this.humidity,
      required this.dailyWeather,
      required this.weatherIconUrl});

  @override
  List<Object?> get props => [
        query,
        temperatureC,
        windSpeedMiles,
        humidity,
        observationTime,
        dailyWeather,
        weatherIconUrl
      ];
}
//   WeatherModelM copyWith({
//   final String observationTime;
//   final String query;
//   final double temperatureC;
//   final int windSpeedMiles;
//   final int humidity;
//   }) {
//     return WeatherModelM(
//       observationTime: observationTime ?? this.observationTime,
//       query: firstqueryName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       password: password ?? this.password,
//       generalDepartment: generalDepartment ?? this.generalDepartment,
//       departmentId: departmentId ?? this.departmentId,
//       department: department ?? this.department,
//       otp: otp ?? this.otp,
//       token: token ?? this.token,
//       examType: examType ?? this.examType,
//     );
//   }
// }
