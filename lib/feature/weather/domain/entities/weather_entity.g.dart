// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WeatherEntity _$$_WeatherEntityFromJson(Map<String, dynamic> json) =>
    _$_WeatherEntity(
      coord: json['coord'] == null
          ? const Coord()
          : Coord.fromJson(json['coord'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      base: json['base'] as String? ?? '',
      main: json['main'] == null
          ? const Main()
          : Main.fromJson(json['main'] as Map<String, dynamic>),
      visibility: json['visibility'] as int?,
      wind: json['wind'] == null
          ? const Wind()
          : Wind.fromJson(json['wind'] as Map<String, dynamic>),
      clouds: json['clouds'] == null
          ? const Clouds()
          : Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
      dt: json['dt'] as int? ?? 0,
      sys: json['sys'] == null
          ? const Sys()
          : Sys.fromJson(json['sys'] as Map<String, dynamic>),
      timezone: json['timezone'] as int? ?? 0,
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      cod: json['cod'] as int? ?? 0,
    );

Map<String, dynamic> _$$_WeatherEntityToJson(_$_WeatherEntity instance) =>
    <String, dynamic>{
      'coord': instance.coord,
      'weather': instance.weather,
      'base': instance.base,
      'main': instance.main,
      'visibility': instance.visibility,
      'wind': instance.wind,
      'clouds': instance.clouds,
      'dt': instance.dt,
      'sys': instance.sys,
      'timezone': instance.timezone,
      'id': instance.id,
      'name': instance.name,
      'cod': instance.cod,
    };

_$_Clouds _$$_CloudsFromJson(Map<String, dynamic> json) => _$_Clouds(
      all: json['all'] as int? ?? 0,
    );

Map<String, dynamic> _$$_CloudsToJson(_$_Clouds instance) => <String, dynamic>{
      'all': instance.all,
    };

_$_Coord _$$_CoordFromJson(Map<String, dynamic> json) => _$_Coord(
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$_CoordToJson(_$_Coord instance) => <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };

_$_Main _$$_MainFromJson(Map<String, dynamic> json) => _$_Main(
      temp: (json['temp'] as num?)?.toDouble() ?? 0.0,
      feelsLike: (json['feels_like'] as num?)?.toDouble() ?? 0.0,
      tempMin: (json['temp_min'] as num?)?.toDouble() ?? 0.0,
      tempMax: (json['temp_max'] as num?)?.toDouble() ?? 0.0,
      pressure: json['pressure'] as int? ?? 0,
      humidity: json['humidity'] as int? ?? 0,
    );

Map<String, dynamic> _$$_MainToJson(_$_Main instance) => <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
    };

_$_Sys _$$_SysFromJson(Map<String, dynamic> json) => _$_Sys(
      type: json['type'] as int? ?? 0,
      id: json['id'] as int? ?? 0,
      country: json['country'] as String? ?? "",
      sunrise: json['sunrise'] as int? ?? 0,
      sunset: json['sunset'] as int? ?? 0,
    );

Map<String, dynamic> _$$_SysToJson(_$_Sys instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'country': instance.country,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };

_$_Weather _$$_WeatherFromJson(Map<String, dynamic> json) => _$_Weather(
      id: json['id'] as int? ?? 0,
      main: json['main'] as String? ?? "",
      description: json['description'] as String? ?? "",
      icon: json['icon'] as String? ?? "",
    );

Map<String, dynamic> _$$_WeatherToJson(_$_Weather instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

_$_Wind _$$_WindFromJson(Map<String, dynamic> json) => _$_Wind(
      speed: (json['speed'] as num?)?.toDouble() ?? 0.0,
      deg: json['deg'] as int? ?? 0,
      gust: (json['gust'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$_WindToJson(_$_Wind instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust,
    };
