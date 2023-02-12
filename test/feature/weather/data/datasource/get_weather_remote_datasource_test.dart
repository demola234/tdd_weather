import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice_tdd/core/config/endpoint_manager.dart';
import 'package:practice_tdd/core/config/network_config.dart';
import 'package:practice_tdd/core/consts/api_const.dart';
import 'package:practice_tdd/core/error/exceptions.dart';
import 'package:practice_tdd/feature/weather/data/datasource/get_weather_remote_datasource.dart';
import 'package:practice_tdd/feature/weather/domain/entities/weather_entity.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockNetworkProvider extends Mock implements NetworkProvider {}

void main() {
  late MockNetworkProvider mockNetworkProvider;
  late GetWeatherRemoteDatasource getWeatherRemoteDatasourceImpl;
  late String tCityName;
  late String apiKey;

  setUp(() {
    mockNetworkProvider = MockNetworkProvider();
    getWeatherRemoteDatasourceImpl =
        GetWeatherRemoteDatasourceImpl(mockNetworkProvider);
    tCityName = "London";
    apiKey = ApiConstants.API_KEY;
  });

  void setUpMockHttpManager() {
    when(() => mockNetworkProvider.call(
        path: EndpointManager.getWeather,
        method: RequestMethod.get,
        body: {"q": tCityName, "appid": apiKey})).thenAnswer((_) async {
      return Response(
          requestOptions: RequestOptions(path: EndpointManager.getWeather),
          data: json.decode(fixture('weather.json')),
          statusCode: 200);
    });
  }

  group("getWeatherInfo", () {
    test("should return WeatherEntity when the call is successful", () async {
      setUpMockHttpManager();
      final result = await getWeatherRemoteDatasourceImpl.getWeather(tCityName);
      expect(result, isA<WeatherEntity>());
    });

    test("should throw ServerException when the call is unsuccessful",
        () async {
      when(() => mockNetworkProvider.call(
          path: EndpointManager.getWeather,
          method: RequestMethod.get,
          body: {"q": tCityName, "appid": apiKey})).thenAnswer((_) async {
        return Response(
            requestOptions: RequestOptions(path: EndpointManager.getWeather),
            data: json.decode(fixture('weather.json')),
            statusCode: 400);
      });
      final call = getWeatherRemoteDatasourceImpl.getWeather;
      expect(() => call(tCityName), throwsA(isA<ServerException>()));
    });
  });
}