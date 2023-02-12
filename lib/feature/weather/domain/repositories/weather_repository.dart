import 'package:practice_tdd/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:practice_tdd/feature/weather/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getWeather(String cityName);
}
