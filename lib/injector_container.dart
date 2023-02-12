import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:practice_tdd/core/config/base_api.dart';
import 'package:practice_tdd/core/config/network_config.dart';
import 'package:practice_tdd/core/network/network_info.dart';
import 'package:practice_tdd/feature/weather/data/datasource/get_weather_local_datasource.dart';
import 'package:practice_tdd/feature/weather/data/datasource/get_weather_remote_datasource.dart';
import 'package:practice_tdd/feature/weather/data/repositories/weather_repository_impl.dart';
import 'package:practice_tdd/feature/weather/domain/repositories/weather_repository.dart';
import 'package:practice_tdd/feature/weather/domain/usecases/get_weather_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.I;

Future<void> injector() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  sl
    //Repository
    ..registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()),
    )

    //UseCase
    ..registerLazySingleton<GetWeatherInfo>(
      () => GetWeatherInfo(sl()),
    )

    // DataSources
    ..registerLazySingleton<GetWeatherRemoteDatasource>(
      () => GetWeatherRemoteDatasourceImpl(
        sl(),
      ),
    )
    //Network
    ..registerLazySingleton<NetworkProvider>(NetworkProviderImpl.new)
    ..registerLazySingleton<GetWeatherLocalDatasource>(
      () => GetWeatherLocalDatasourceImpl(
        sharedPreferences: sl(),
      ),
    )
    ..registerLazySingleton<SharedPreferences>(() => sharedPrefs)

    //Network
    ..registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(InternetConnectionChecker()));
}
