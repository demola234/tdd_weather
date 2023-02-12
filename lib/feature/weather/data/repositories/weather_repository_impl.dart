import 'package:practice_tdd/core/error/exceptions.dart';
import 'package:practice_tdd/core/network/network_info.dart';
import 'package:practice_tdd/feature/weather/data/datasource/get_weather_local_datasource.dart';
import 'package:practice_tdd/feature/weather/data/datasource/get_weather_remote_datasource.dart';
import 'package:practice_tdd/feature/weather/domain/entities/weather_entity.dart';
import 'package:practice_tdd/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:practice_tdd/feature/weather/domain/repositories/weather_repository.dart';

typedef _GetWeather = Future<WeatherEntity> Function();

class WeatherRepositoryImpl implements WeatherRepository {
  late GetWeatherRemoteDatasource remoteDataSource;
  late GetWeatherLocalDatasource localDataSource;
  late NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, WeatherEntity>> getWeather(String cityName) async {
    return await _getWeather(() => remoteDataSource.getWeather(cityName));
  }

  Future<Either<Failure, WeatherEntity>> _getWeather(
      _GetWeather getWeather) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await getWeather();
        localDataSource.cacheWeather(remoteWeather);
        return Right(remoteWeather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localWeather = await localDataSource.getLastWeather();
        return Right(localWeather);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
