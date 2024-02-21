import 'package:fpdart/fpdart.dart';
import 'package:weather_app/src/utils/utils.dart';
import 'package:weather_app/src/weather/domain/domain.dart';

class ApiWeather extends WeatherRepository {
  const ApiWeather({required this.http});

  final MsDio http;

  @override
  Future<Either<Failure, EWeather>> loadWeatherByLatLon({
    double lat = 0.0,
    double lon = 0.0,
    UnitsType units = UnitsType.celsius,
  }) async {
    try {
      final res = await http.dio.get(
        '/data/3.0/onecall',
        queryParameters: {
          'appid': '----',
          'exclude': 'daily,minutely,hourly',
          'lat': lat,
          'lon': lon,
          'units': (UnitsType.celsius == units) ? 'metric' : 'imperial'
        },
      );

      final model = EWeather.fromJson(res.data ?? {});

      return Right(model);
    } catch (e) {
      return Left(
        Failure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, EGeocoding>> loadWeatherByName({
    String cityName = '',
    UnitsType units = UnitsType.celsius,
  }) async {
    try {
      final res = await http.dio.get(
        '/geo/1.0/direct',
        queryParameters: {
          'appid': '----',
          'q': cityName,
          'limit': 2,
        },
      );

      final model = EGeocoding.fromJson(res.data[0] ?? {});

      return Right(model);
    } catch (e) {
      return const Left(
        Failure(
          message: 'City not found',
        ),
      );
    }
  }
}
