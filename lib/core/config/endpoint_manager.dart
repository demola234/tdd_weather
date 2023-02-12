import 'package:practice_tdd/core/consts/api_const.dart';

class EndpointManager {
  static const String _weather = ApiConstants.BASE_URL;

  static const String getWeather = 'https://$_weather/weather';
}
