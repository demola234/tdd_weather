import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:mockito/annotations.dart';
import 'package:practice_tdd/core/error/exceptions.dart';
import 'package:practice_tdd/feature/weather/data/datasource/get_weather_local_datasource.dart';
import 'package:practice_tdd/feature/weather/domain/entities/weather_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'get_weather_local_datasource_test.mocks.dart';

@GenerateMocks([
  SharedPreferences
], customMocks: [
  MockSpec<SharedPreferences>(
      as: #MockSharedPreferencesForTest),
])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late GetWeatherLocalDatasourceImpl getWeatherLocalDatasourceImpl;
  late WeatherEntity tWeatherEntity;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    getWeatherLocalDatasourceImpl = GetWeatherLocalDatasourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
    tWeatherEntity = const WeatherEntity(
        coord: Coord(lat: 51.5085, lon: -0.1257),
        weather: [
          Weather(
            id: 800,
            main: "Clear",
            description: "clear sky",
            icon: "09d",
          ),
        ],
        base: "stations",
        main: Main(
            temp: 279.05,
            feelsLike: 277.61,
            tempMin: 276.96,
            tempMax: 281.46,
            pressure: 1033,
            humidity: 77),
        visibility: 10000,
        wind: Wind(speed: 1.96, deg: 192, gust: 3.36),
        clouds: Clouds(all: 5),
        dt: 1675859196,
        sys: Sys(
            type: 2,
            id: 2075535,
            country: "GB",
            sunrise: 1675841287,
            sunset: 1675875677),
        timezone: 0,
        id: 2643743,
        name: "London",
        cod: 200);
  });

  const cacheWeather = "CACHED_WEATHER";
  group("getLastWeather", () {
    test(
        "should return WeatherEntity from SharedPreferences when there is one in the cache",
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('weather_cached.json'));
      // act
      final result = await getWeatherLocalDatasourceImpl.getLastWeather();
      // assert
      verify(mockSharedPreferences.getString(cacheWeather));
      expect(result, equals(tWeatherEntity));
    });

    test("should throw a CacheException when there is not a cached value",
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = getWeatherLocalDatasourceImpl.getLastWeather;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group("should cache weather when ever there is a new weather", () {
    test("should call SharedPreferences to cache the data", () async {
      // arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      // act
      getWeatherLocalDatasourceImpl.cacheWeather(tWeatherEntity);
      // assert
      final expectedJsonString = json.encode(tWeatherEntity.toJson());
      verify(mockSharedPreferences.setString(cacheWeather, expectedJsonString));
    });

    test("should throw a CacheException when there is an error", () async {
      // arrange
      when(mockSharedPreferences.setString(any, any)).thenThrow(CacheException());
      // act
      final call = getWeatherLocalDatasourceImpl.cacheWeather;
      // assert
      expect(() => call(tWeatherEntity), throwsA(isA<CacheException>()));
    });
  });
}
