part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();
}

final class OnLoadByLatLonEvent extends WeatherEvent {
  const OnLoadByLatLonEvent({
    required this.lat,
    required this.lon,
    required this.units,
  });
  final double lat;
  final double lon;
  final UnitsType units;

  @override
  List<Object?> get props => [lat, lon, units];
}

final class OnLoadByCityNameEvent extends WeatherEvent {
  const OnLoadByCityNameEvent({
    required this.cityName,
    this.units,
  });
  final String cityName;
  final UnitsType? units;

  @override
  List<Object?> get props => [cityName, units];
}

final class OnLoadByGPS extends WeatherEvent {
  const OnLoadByGPS({
    required this.units,
  });

  final UnitsType units;

  @override
  List<Object?> get props => [units];
}
