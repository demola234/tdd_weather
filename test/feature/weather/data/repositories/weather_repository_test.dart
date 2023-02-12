import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';

import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice_tdd/core/error/exceptions.dart';
import 'package:practice_tdd/core/error/failure.dart';

import 'package:practice_tdd/core/network/network_info.dart';
import 'package:practice_tdd/feature/weather/data/datasource/get_weather_local_datasource.dart';
import 'package:practice_tdd/feature/weather/data/datasource/get_weather_remote_datasource.dart';
import 'package:practice_tdd/feature/weather/data/repositories/weather_repository_impl.dart';
import 'package:practice_tdd/feature/weather/domain/entities/weather_entity.dart';

import 'weather_repository_test.mocks.dart';

class MockLocalDataSource extends Mock implements GetWeatherLocalDatasource {}

@GenerateMocks([NetworkInfo])
@GenerateMocks([GetWeatherRemoteDatasource])
void main() {
  late WeatherRepositoryImpl weatherRepositoryImpl;
  late GetWeatherRemoteDatasource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late String tCityName;
  late WeatherEntity tWeatherEntity;

  setUp(() {
    mockRemoteDataSource = MockGetWeatherRemoteDatasource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    weatherRepositoryImpl = WeatherRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
    tCityName = "London";
    tWeatherEntity = const WeatherEntity(weather: [Weather()]);

    group("device is online", () {
      setUp(() {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          "should return remote data when the call to remote data source is successful",
          () async {
        // arrange
        when(() => mockRemoteDataSource.getWeather(any()))
            .thenAnswer((_) async => tWeatherEntity);

        // act
        final result = await weatherRepositoryImpl.getWeather(tCityName);

        // assert
        verify(() => mockRemoteDataSource.getWeather(tCityName));
        expect(result, equals(Right(tWeatherEntity)));
      });

      test(
          "should cache the data locally when the call to remote data source is successful",
          () async {
        // arrange
        when(() => mockRemoteDataSource.getWeather(any()))
            .thenAnswer((_) async => tWeatherEntity);

        // act
        await weatherRepositoryImpl.getWeather(any());

        // assert
        verify(() => mockRemoteDataSource.getWeather(tCityName));
        verify(() => mockLocalDataSource.cacheWeather(tWeatherEntity));
      });

      test(
          "should return server failure when the call to remote data source is unsuccessful",
          () async {
        when(() => mockRemoteDataSource.getWeather(tCityName))
            .thenThrow(ServerException(message: "failure"));

        final result = await weatherRepositoryImpl.getWeather(tCityName);

        verify(() => mockRemoteDataSource.getWeather(tCityName));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group("device is offline", () {
      setUp(() {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test(
          "should return last locally cached data when the cached data is present",
          () async {
        // arrange
        when(() => mockLocalDataSource.getLastWeather())
            .thenAnswer((_) async => tWeatherEntity);

        // act
        final result = await weatherRepositoryImpl.getWeather(tCityName);

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getLastWeather());
        expect(result, equals(Right(tWeatherEntity)));
      });
    });
  });
}
