import 'package:dartz/dartz.dart';
import 'package:practice_tdd/feature/weather/domain/entities/weather_entity.dart';
import 'package:practice_tdd/feature/weather/domain/repositories/weather_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:practice_tdd/feature/weather/domain/usecases/get_weather_info.dart';

import 'get_weather_info_test.mocks.dart';

@GenerateMocks([WeatherRepository])

void main() {
  late GetWeatherInfo usecase;
  late MockWeatherRepository mockWeatherRepository;
  late String tCityName;
  late WeatherEntity tWeatherEntity;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetWeatherInfo(mockWeatherRepository);
    tCityName = "London";
    tWeatherEntity = const WeatherEntity(
      coord: Coord(lon: 0.0, lat: 0.0),
      weather: [],
      base: "",
      main: Main(
        temp: 0.0,
        feelsLike: 0.0,
        tempMin: 0.0,
        tempMax: 0.0,
        pressure: 0,
        humidity: 0,
      ),
      visibility: 0,
      wind: Wind(speed: 0.0, deg: 0, gust: 0.0),
      clouds: Clouds(all: 0),
      dt: 0,
      sys: Sys(type: 0, id: 0, country: "", sunrise: 0, sunset: 0),
      timezone: 0,
      id: 0,
      name: "",
      cod: 0,
    );
  });


  test("should get the weather for the city from the repository", () async {
    // arrange
    when(mockWeatherRepository.getWeather(tCityName))
        .thenAnswer((_) async => Right(tWeatherEntity));

    // act
    final result = await usecase.call(Params(cityName: tCityName));

    // assert
    expect(result, Right(tWeatherEntity));
    verify(mockWeatherRepository.getWeather(tCityName));
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
