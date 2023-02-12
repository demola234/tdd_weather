import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'weather_entity.freezed.dart';
part 'weather_entity.g.dart';

@freezed
class WeatherEntity with _$WeatherEntity {
  const factory WeatherEntity({
    @Default(Coord()) Coord? coord,
    required List<Weather> weather,
    @Default('') String base,
    @Default(Main()) Main? main,
    int? visibility,
    @Default(Wind()) Wind? wind,
    @Default(Clouds()) Clouds? clouds,
    @Default(0) int? dt,
    @Default(Sys()) Sys? sys,
    @Default(0) int? timezone,
    @Default(0) int? id,
    @Default('') String? name,
    @Default(0) int? cod,
  }) = _WeatherEntity;

  factory WeatherEntity.fromJson(Map<String, dynamic> json) =>
      _$WeatherEntityFromJson(json);
}

@freezed
class Clouds with _$Clouds {
  const factory Clouds({
    @Default(0) int? all,
  }) = _Clouds;

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);
}

@freezed
class Coord with _$Coord {
  const factory Coord({
    @Default(0.0) double? lon,
    @Default(0.0) double? lat,
  }) = _Coord;

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);
}

@freezed
class Main with _$Main {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Main({
    @Default(0.0) double? temp,
    @Default(0.0) double? feelsLike,
    @Default(0.0) double? tempMin,
    @Default(0.0) double? tempMax,
    @Default(0) int? pressure,
    @Default(0) int? humidity,
  }) = _Main;

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
}

@freezed
class Sys with _$Sys {
  const factory Sys({
    @Default(0) int? type,
    @Default(0) int? id,
    @Default("") String? country,
    @Default(0) int? sunrise,
    @Default(0) int? sunset,
  }) = _Sys;

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);
}

@freezed
class Weather with _$Weather {
  const factory Weather({
    @Default(0) int? id,
    @Default("") String? main,
    @Default("") String? description,
    @Default("") String? icon,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

@freezed
class Wind with _$Wind {
  const factory Wind({
    @Default(0.0) double? speed,
    @Default(0) int? deg,
    @Default(0.0) double? gust,
  }) = _Wind;

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
}
