import 'dart:convert';

import 'package:practice_tdd/core/config/base_api.dart';
import 'package:practice_tdd/core/config/endpoint_manager.dart';
import 'package:practice_tdd/core/config/network_config.dart';
import 'package:practice_tdd/core/consts/api_const.dart';
import 'package:practice_tdd/core/error/exceptions.dart';
import 'package:practice_tdd/feature/weather/domain/entities/weather_entity.dart';

abstract class GetWeatherRemoteDatasource {
  Future<WeatherEntity> getWeather(String cityName);
}

class GetWeatherRemoteDatasourceImpl implements GetWeatherRemoteDatasource {
  final NetworkProvider client;
  String apiKey = ApiConstants.API_KEY;
  String baseUrl = ApiConstants.BASE_URL;
  GetWeatherRemoteDatasourceImpl(this.client);

  @override
  Future<WeatherEntity> getWeather(String cityName) async {
    final response = await client.call(
        path: EndpointManager.getWeather,
        method: RequestMethod.get,
        body: {"q": cityName, "appid": apiKey});
    final res =  response!.data;
    if (response.statusCode == 200) {
      return WeatherEntity.fromJson(res);
    } else {
      throw ServerException(message: 'Server Error');
    }
  }
}
