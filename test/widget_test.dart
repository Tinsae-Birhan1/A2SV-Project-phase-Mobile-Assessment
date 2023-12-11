import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assesment/core/error/exception.dart';
import 'package:mobile_assesment/core/error/failure.dart';
import 'package:mobile_assesment/core/network/network.dart';
import 'package:mobile_assesment/weathers/data/datasource/datasources.dart';
import 'package:mobile_assesment/weathers/data/model/models.dart';
import 'package:mobile_assesment/weathers/data/repostory/repositories.dart';
import 'package:mobile_assesment/weathers/domain/entity/weather.dart';
import 'package:mobile_assesment/weathers/domain/repostory/weather_repostory.dart';
import 'package:mobile_assesment/weathers/domain/usecase/weather_usecase.dart';
import 'package:mockito/mockito.dart';

class MockWeatherRemoteDatasource extends Mock
    implements WeatherRemoteDatasource {}

class MockFavoriteWeatherLocalDatasource extends Mock
    implements FavoriteWeatherLocalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockWeatherRemoteDatasource mockRemoteDatasource;
  late MockFavoriteWeatherLocalDatasource mockLocalDatasource;
  late MockNetworkInfo mockNetworkInfo;
  late WeatherRepositoryImpl repository;
  late WeatherUsecase usecase;

  setUp(() {
    mockRemoteDatasource = MockWeatherRemoteDatasource();
    mockLocalDatasource = MockFavoriteWeatherLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = WeatherRepositoryImpl(
      remoteDatasource: mockRemoteDatasource,
      localDatasource: mockLocalDatasource,
      networkInfo: mockNetworkInfo,
    );
    usecase = WeatherUsecase(repository: repository);
  });

  group('getWeatherForCity', () {
    const searchQuery = 'London';
    const weatherModel = WeatherModel(
      observationTime: 'now',
      query: 'London',
      temperatureC: '20',
      windSpeedMiles: '5',
      humidity: '60',
      dailyWeather: [],
      weatherIconUrl: 'https://example.com/icon.png',
    );

    test('should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // Act
      await usecase(WeatherParams(search: searchQuery));

      // Assert
      verify(mockNetworkInfo.isConnected);
    });

    test(
        'should return Weather when the call to remote datasource is successful',
        () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDatasource.getWeather(search: anyNamed('search')))
          .thenAnswer((_) async => weatherModel);

      // Act
      final result = await usecase(WeatherParams(search: searchQuery));

      // Assert
      expect(result, Right(weatherModel));
      verify(mockRemoteDatasource.getWeather(search: searchQuery));
    });

    test('should return NetworkFailure when device is offline', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await usecase(WeatherParams(search: searchQuery));

      // Assert
      expect(result, Left(NetworkFailure()));
      verifyZeroInteractions(mockRemoteDatasource);
    });

    test('should return ServerFailure on remote data source exception',
        () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDatasource.getWeather(search: anyNamed('search')))
          .thenThrow(ServerException());

      // Act
      final result = await usecase(WeatherParams(search: searchQuery));

      // Assert
      expect(result, Left(ServerFailure()));
      verify(mockRemoteDatasource.getWeather(search: searchQuery));
    });

    test('should return CacheFailure on remote data source exception',
        () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDatasource.getWeather(search: anyNamed('search')))
          .thenThrow(CacheException());

      // Act
      final result = await usecase(WeatherParams(search: searchQuery));

      // Assert
      expect(result, Left(CacheFailure()));
      verify(mockRemoteDatasource.getWeather(search: searchQuery));
    });
  });
}
