import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_tdd/feature/weather/domain/repositories/weather_repository.dart';
import 'package:practice_tdd/feature/weather/domain/usecases/get_weather_info.dart';
import 'package:practice_tdd/feature/weather/presentation/riverpod/notifiers/weather_notifier.dart';
import 'package:practice_tdd/feature/weather/presentation/riverpod/state/get_weather_state.dart';
import 'package:practice_tdd/injector_container.dart';

GetWeatherInfo weatherRepository = sl<GetWeatherInfo>();

final weatherNotifierProvider =
    StateNotifierProvider<WeatherNotifier, WeatherState>(
  (ref) => WeatherNotifier(weatherRepository),
);
