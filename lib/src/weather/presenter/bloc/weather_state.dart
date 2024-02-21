part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState({
    required this.units,
    required this.weather,
    required this.search,
  });

  final UnitsType units;
  final EWeather weather;
  final String search;

  @override
  List<Object?> get props => [units, search, weather];
}

final class WeatherInitial extends WeatherState {
  const WeatherInitial({
    required super.units,
    required super.weather,
    required super.search,
  });

  @override
  List<Object?> get props => [units, search, weather];
}

final class ShowLoading extends WeatherState {
  const ShowLoading({
    required super.units,
    required super.weather,
    this.message = '',
    required super.search,
  });

  final String message;

  @override
  List<Object?> get props => [units, search, weather, message];
}

final class CloseLoading extends WeatherState {
  const CloseLoading(
      {required super.units, required super.weather, required super.search});

  @override
  List<Object?> get props => [units, search, weather];
}

final class WeatherLoaded extends WeatherState {
  const WeatherLoaded(
      {required super.weather, required super.units, required super.search});

  @override
  List<Object?> get props => [units, search, weather];
}

final class WeatherGeocodingLoaded extends WeatherState {
  const WeatherGeocodingLoaded({
    required this.geocoding,
    required super.units,
    required super.weather,
    required super.search,
  });

  final EGeocoding geocoding;

  @override
  List<Object?> get props => [geocoding, units, search, weather];
}

final class WeatherFailure extends WeatherState {
  const WeatherFailure({
    required this.failure,
    required super.units,
    required super.weather,
    required super.search,
  });

  final Failure failure;

  @override
  List<Object?> get props => [failure, units, search, weather];
}

final class NoInternetState extends WeatherState {
  const NoInternetState({
    required super.units,
    required super.weather,
    required super.search,
  });

  @override
  List<Object?> get props => [units, search, weather];
}
