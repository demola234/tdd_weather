import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:practice_tdd/core/error/failure.dart';
import 'package:practice_tdd/feature/weather/domain/entities/weather_entity.dart';

part 'get_weather_state.freezed.dart';

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState.initial() = _Initial;
  const factory WeatherState.loading() = Loading;
  const factory WeatherState.getWeather(
      {required WeatherEntity weatherEntity}) = GetWeather;
  const factory WeatherState.error({required Failure error}) = _Error;
}
