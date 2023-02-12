import 'dart:convert';

import 'package:practice_tdd/core/error/exceptions.dart';
import 'package:practice_tdd/feature/weather/domain/entities/weather_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GetWeatherLocalDatasource {
  Future<WeatherEntity> getLastWeather();
  Future<void> cacheWeather(WeatherEntity weatherToCache);
}

class GetWeatherLocalDatasourceImpl implements GetWeatherLocalDatasource {
  final SharedPreferences sharedPreferences;

  GetWeatherLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheWeather(WeatherEntity weatherToCache) {
    try {
      return sharedPreferences.setString(
          'CACHED_WEATHER', json.encode(weatherToCache.toJson()));
    } on CacheException {
      throw CacheException();
    }
  }

  @override
  Future<WeatherEntity> getLastWeather() {
    final jsonString = sharedPreferences.getString('CACHED_WEATHER');
    if (jsonString != null) {
      return Future.value(WeatherEntity.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
