import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:practice_tdd/core/error/failure.dart';
import 'package:practice_tdd/feature/weather/domain/entities/weather_entity.dart';
import 'package:practice_tdd/feature/weather/domain/repositories/weather_repository.dart';

import '../../../../core/usecases/usecases.dart';

class GetWeatherInfo implements UseCase<WeatherEntity, Params>{
  final WeatherRepository weatherRepository;

  GetWeatherInfo(this.weatherRepository);

  @override
  Future<Either<Failure, WeatherEntity>> call(Params params) async {
    return await weatherRepository.getWeather(params.cityName);
  }
}

class Params extends Equatable {
  final String cityName;
  const Params({
    required this.cityName,
  });

  @override
  List<Object> get props => [cityName];
}