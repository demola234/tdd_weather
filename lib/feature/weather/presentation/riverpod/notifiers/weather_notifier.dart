import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_tdd/core/error/failure.dart';
import 'package:practice_tdd/feature/weather/domain/usecases/get_weather_info.dart';
import 'package:practice_tdd/feature/weather/presentation/riverpod/state/get_weather_state.dart';

class WeatherNotifier extends StateNotifier<WeatherState> {
  final GetWeatherInfo getWeatherInfo;
  WeatherNotifier(this.getWeatherInfo) : super(const WeatherState.initial());

  Future<void> getWeather({required String cityName}) async {
    state = const WeatherState.loading();

    final result = await getWeatherInfo(Params(cityName: cityName));
    result.fold(
      (l) {
        state = WeatherState.error(error: ServerFailure());
      },
      (r) {
        state = WeatherState.getWeather(weatherEntity: r);
      },
    );
  }
}
