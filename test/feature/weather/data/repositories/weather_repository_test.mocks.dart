// Mocks generated by Mockito 5.3.2 from annotations
// in practice_tdd/test/feature/weather/data/repositories/weather_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:practice_tdd/core/network/network_info.dart' as _i3;
import 'package:practice_tdd/feature/weather/data/datasource/get_weather_remote_datasource.dart'
    as _i5;
import 'package:practice_tdd/feature/weather/domain/entities/weather_entity.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWeatherEntity_0 extends _i1.SmartFake implements _i2.WeatherEntity {
  _FakeWeatherEntity_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i3.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}

/// A class which mocks [GetWeatherRemoteDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWeatherRemoteDatasource extends _i1.Mock
    implements _i5.GetWeatherRemoteDatasource {
  MockGetWeatherRemoteDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.WeatherEntity> getWeather(String? cityName) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWeather,
          [cityName],
        ),
        returnValue: _i4.Future<_i2.WeatherEntity>.value(_FakeWeatherEntity_0(
          this,
          Invocation.method(
            #getWeather,
            [cityName],
          ),
        )),
      ) as _i4.Future<_i2.WeatherEntity>);
}
