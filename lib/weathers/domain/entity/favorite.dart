// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:mobile_assesment/weathers/data/model/models.dart';

class Favorite extends Equatable {
  final String query;
  final String temperatureC;
  final String weatherIconUrl;
  Favorite(
      {required this.query,
      required this.temperatureC,
      required this.weatherIconUrl});

  @override
  List<Object?> get props => [query, temperatureC, weatherIconUrl];
}
