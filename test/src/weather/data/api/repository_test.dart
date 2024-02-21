import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/src/utils/utils.dart';
import 'package:weather_app/src/weather/domain/domain.dart';

class WeatherRepositoryMock extends Mock implements WeatherRepository {}

void main() {
  test(
    'loadWeatherByLatLon returns EWeather on success',
    () async {
      final apiWeather = WeatherRepositoryMock();
      const lat = 0.0;
      const lon = 0.0;

      when(
        () => apiWeather.loadWeatherByLatLon(lat: lat, lon: lon),
      ).thenAnswer(
        (_) async => Right(
          EWeather.fromJson({}),
        ),
      );

      final result = await apiWeather.loadWeatherByLatLon(lat: lat, lon: lon);

      expect(result.isRight(), true);
      expect(result.isLeft(), false);
    },
  );

  test(
    'loadWeatherByLatLon returns EWeather on failure',
    () async {
      final apiWeather = WeatherRepositoryMock();
      const lat = 0.0;
      const lon = 0.0;

      when(
        () => apiWeather.loadWeatherByLatLon(lat: lat, lon: lon),
      ).thenAnswer(
        (_) async => const Left(Failure(message: '')),
      );

      final result = await apiWeather.loadWeatherByLatLon(lat: lat, lon: lon);

      expect(result.isRight(), false);
      expect(result.isLeft(), true);
    },
  );

  test(
    'loadWeatherByName returns EWeather on success',
    () async {
      final apiWeather = WeatherRepositoryMock();
      const cityName = 'london';

      when(
        () => apiWeather.loadWeatherByName(cityName: cityName),
      ).thenAnswer(
        (_) async => Right(
          EGeocoding.fromJson({
            'lat': 12.0,
            'lon': 12.0,
          }),
        ),
      );

      final result = await apiWeather.loadWeatherByName(cityName: cityName);

      expect(result.isRight(), true);
      expect(result.isLeft(), false);
    },
  );

  test(
    'loadWeatherByName returns EWeather on failure',
    () async {
      final apiWeather = WeatherRepositoryMock();
      const cityName = 'london';

      when(
        () => apiWeather.loadWeatherByName(cityName: cityName),
      ).thenAnswer(
        (_) async => const Left(Failure(message: '')),
      );

      final result = await apiWeather.loadWeatherByName(cityName: cityName);

      expect(result.isRight(), false);
      expect(result.isLeft(), true);
    },
  );
}
