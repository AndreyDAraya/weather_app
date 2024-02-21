import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/src/utils/utils.dart';
import 'package:weather_app/src/weather/domain/domain.dart';
import 'package:weather_app/src/weather/presenter/bloc/weather_bloc.dart';

class WeatherRepositoryMock extends Mock implements WeatherRepository {}

class WeatherBlocMock extends WeatherBloc with ConnectionState {
  WeatherBlocMock(super.repository);

  @override
  Future<bool> hasInternet() async => true;
}

main() {
  late WeatherBlocMock bloc;
  late WeatherRepositoryMock repository;

  setUp(() {
    repository = WeatherRepositoryMock();
    bloc = WeatherBlocMock(repository);
  });

  blocTest(
    'emits [ShowLoading, CloseLoading, WeatherLoaded] when OnLoadByLatLonEvent is added',
    build: () {
      when(
        () => repository.loadWeatherByLatLon(
          lat: any(named: 'lat'),
          lon: any(named: 'lon'),
        ),
      ).thenAnswer(
        (_) async => Right(
          EWeather.fromJson({}),
        ),
      );

      return bloc;
    },
    act: (bloc) {
      return bloc.add(
        const OnLoadByLatLonEvent(
          lat: 0.0,
          lon: 0.0,
          units: UnitsType.celsius,
        ),
      );
    },
    expect: () => [
      isA<ShowLoading>(),
      isA<CloseLoading>(),
      isA<WeatherLoaded>(),
    ],
    verify: (_) {
      verify(() => repository.loadWeatherByLatLon(
            lat: any(named: 'lat'),
            lon: any(named: 'lon'),
          )).called(1);
    },
  );

  blocTest(
    'emits [ShowLoading, CloseLoading, WeatherGeocodingLoaded, ShowLoading, CloseLoading, WeatherLoaded] when OnLoadByCityNameEvent is added',
    build: () {
      when(
        () => repository.loadWeatherByName(
          cityName: any(named: 'cityName'),
        ),
      ).thenAnswer(
        (_) async => Right(
          EGeocoding.fromJson({
            'lat': 0.0,
            'lon': 0.0,
          }),
        ),
      );

      when(
        () => repository.loadWeatherByLatLon(
          lat: any(named: 'lat'),
          lon: any(named: 'lon'),
        ),
      ).thenAnswer(
        (_) async => Right(
          EWeather.fromJson({}),
        ),
      );
      return bloc;
    },
    act: (bloc) {
      return bloc.add(
        const OnLoadByCityNameEvent(
          cityName: 'London',
        ),
      );
    },
    expect: () => [
      isA<ShowLoading>(),
      isA<CloseLoading>(),
      isA<WeatherGeocodingLoaded>(),
      isA<ShowLoading>(),
      isA<CloseLoading>(),
      isA<WeatherLoaded>(),
    ],
    verify: (_) {
      verify(() => repository.loadWeatherByName(
            cityName: any(named: 'cityName'),
          )).called(1);
      verify(() => repository.loadWeatherByLatLon(
            lat: any(named: 'lat'),
            lon: any(named: 'lon'),
          )).called(1);
    },
  );
}
