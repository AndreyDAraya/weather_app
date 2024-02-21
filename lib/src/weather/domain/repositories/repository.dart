import 'package:fpdart/fpdart.dart';
import 'package:weather_app/src/utils/utils.dart';
import 'package:weather_app/src/weather/domain/domain.dart';

abstract class WeatherRepository {
  const WeatherRepository();

  /// Loads weather data by latitude and longitude.
  ///
  /// Returns a [Future] that completes with an [Either] object representing either a [Failure] if the request fails,
  /// or an [EWeather] object if the request is successful.
  ///
  /// [lat] and [lon] specify the latitude and longitude coordinates, respectively.
  /// [units] specifies the units type for the weather data. Default value is [UnitsType.celsius].
  Future<Either<Failure, EWeather>> loadWeatherByLatLon({
    double lat = 0.0,
    double lon = 0.0,
    UnitsType units = UnitsType.celsius,
  });

  /// Loads weather data by city name.
  ///
  /// Returns a [Future] that completes with an [Either] object representing either a [Failure] if the request fails,
  /// or an [EGeocoding] object if the request is successful.
  ///
  /// [cityName] specifies the name of the city for which weather data is to be retrieved.
  /// [units] specifies the units type for the weather data. Default value is [UnitsType.celsius].
  Future<Either<Failure, EGeocoding>> loadWeatherByName({
    String cityName = '',
    UnitsType units = UnitsType.celsius,
  });
}
