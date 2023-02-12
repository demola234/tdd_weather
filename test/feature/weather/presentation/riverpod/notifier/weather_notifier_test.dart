import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:practice_tdd/core/error/failure.dart';
import 'package:practice_tdd/feature/weather/domain/entities/weather_entity.dart';
import 'package:practice_tdd/feature/weather/domain/usecases/get_weather_info.dart';
import 'package:practice_tdd/feature/weather/presentation/riverpod/notifiers/weather_notifier.dart';
import 'package:practice_tdd/feature/weather/presentation/riverpod/state/get_weather_state.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

class MockGetWeatherInfo extends Mock implements GetWeatherInfo {}

void main() {
  late MockGetWeatherInfo mockGetWeatherInfo;
  late String tCityName;
  late WeatherEntity tWeatherEntity;
  setUp(() {
    mockGetWeatherInfo = MockGetWeatherInfo();
    tCityName = "London";
  });
  tWeatherEntity = const WeatherEntity(weather: [Weather()]);

  group('get Weather', () {
    stateNotifierTest<WeatherNotifier, WeatherState>(
      'state is GetWeatherLoading when getWeather is called',
      // Arrange - create notifier
      build: () => WeatherNotifier(mockGetWeatherInfo),
      // Arrange - set up dependencies
      setUp: () {
        when(() => mockGetWeatherInfo(Params(cityName: tCityName)))
            .thenAnswer((_) async {
          return Future<Either<Failure, WeatherEntity>>(
            () => Future.value(Right(tWeatherEntity)),
          );
        });
      },
      // Act - call the methods
      actions: (WeatherNotifier stateNotifier) async {
        await stateNotifier.getWeather(cityName: tCityName);
      },
      // Assert
      expect: () => [
        const WeatherState.loading(),
        WeatherState.getWeather(weatherEntity: tWeatherEntity),
      ],
    );

    stateNotifierTest<WeatherNotifier, WeatherState>(
      'state is GetWeatherError when getWeather is called',
      // Arrange - create notifier
      build: () => WeatherNotifier(mockGetWeatherInfo),
      // Arrange - set up dependencies
      setUp: () {
        when(() => mockGetWeatherInfo(Params(cityName: tCityName)))
            .thenAnswer((_) async {
          return Future<Either<Failure, WeatherEntity>>(
              () => Future.value(Left(ServerFailure())));
        });
      },
      // Act - call the methods
      actions: (WeatherNotifier stateNotifier) async {
        await stateNotifier.getWeather(cityName: tCityName);
      },
      // Assert
      expect: () => [
        const WeatherState.loading(),
        WeatherState.error(error: ServerFailure()),
      ],
    );
  });
}
