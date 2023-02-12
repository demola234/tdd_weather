import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:practice_tdd/feature/weather/domain/entities/weather_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tWeatherEntity = WeatherEntity(
    coord: Coord(lon: 0.0, lat: 0.0),
    weather: [
      Weather(
        id: 0,
        main: "",
        description: "",
        icon: "",
      )
    ],
    base: "",
    main: Main(
      temp: 0,
      feelsLike: 0,
      tempMin: 0,
      tempMax: 0,
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

  group("from json", () {
    test("should return a valid model", () {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("weather.json"));
      // act
      final result = WeatherEntity.fromJson(jsonMap);
      // assert
      expect(result, tWeatherEntity);
    });
  });

  group("to json", () {
    test("should be able to send a valid model", () {
      // arrange
      //
      final expectMap = {
        "coord": {
          "lon": 0.0,
          "lat": 0.0,
        },
        "weather": [
          {
            "id": 0,
            "main": "",
            "description": "",
            "icon": "",
          }
        ],
        "base": "",
        "main": {
          "temp": 0,
          "feels_like": 0,
          "temp_min": 0,
          "temp_max": 0,
          "pressure": 0,
          "humidity": 0,
        },
        "visibility": 0,
        "wind": {
          "speed": 0.0,
          "deg": 0,
          "gust": 0.0,
        },
        "clouds": {
          "all": 0,
        },
        "dt": 0,
        "sys": {
          "type": 0,
          "id": 0,
          "country": "",
          "sunrise": 0,
          "sunset": 0,
        },
        "timezone": 0,
        "id": 0,
        "name": "",
        "cod": 0,
      };
      // act
      final result = tWeatherEntity.toJson();
      // assert
      expect(expectMap, json.decode(json.encode(result)));
    });
  });
}
