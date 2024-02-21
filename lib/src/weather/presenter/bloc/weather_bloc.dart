import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/utils/utils.dart';
import 'package:weather_app/src/weather/domain/domain.dart';

part 'weather_event.dart';
part 'weather_state.dart';

/// Bloc responsible for managing weather-related events and states.
class WeatherBloc extends Bloc<WeatherEvent, WeatherState>
    with ConnectionState {
  WeatherBloc(this._repository)
      : super(
          WeatherInitial(
            units: UnitsType.celsius,
            weather: EWeather.fromJson({}),
            search: '',
          ),
        ) {
    // Set up event listeners
    on<OnLoadByLatLonEvent>(__onLoadByLatLon);
    on<OnLoadByCityNameEvent>(_onLoadByCityNameEvent);
    on<OnLoadByGPS>(_onLoadByGPS);
  }

  final WeatherRepository _repository;

  /// Handler for loading weather data by latitude and longitude.
  void __onLoadByLatLon(
      OnLoadByLatLonEvent event, Emitter<WeatherState> emit) async {
    // Check internet connectivity
    if (!await hasInternet()) {
      emit(
        NoInternetState(
          search: state.search,
          weather: state.weather,
          units: state.units,
        ),
      );
      return;
    }

    // Show loading screen
    emit(
      ShowLoading(
        units: state.units,
        weather: state.weather,
        message: 'Getting information...',
        search: state.search,
      ),
    );

    // Make request to load weather data
    final either = await _repository.loadWeatherByLatLon(
      lat: event.lat,
      lon: event.lon,
      units: event.units,
    );

    // Close loading screen
    emit(
      CloseLoading(
        units: state.units,
        weather: state.weather,
        search: state.search,
      ),
    );

    // Handle success or failure response
    either.match(
      (failure) {
        // Show error alert screen
        emit(
          WeatherFailure(
            failure: failure,
            units: state.units,
            weather: state.weather,
            search: state.search,
          ),
        );
      },
      (weather) {
        // Update weather screen
        emit(
          WeatherLoaded(
            weather: weather,
            units: event.units,
            search: state.search,
          ),
        );
      },
    );
  }

  /// Handler for loading weather data by city name.
  FutureOr<void> _onLoadByCityNameEvent(
      OnLoadByCityNameEvent event, Emitter<WeatherState> emit) async {
    // Check internet connectivity
    if (!await hasInternet()) {
      emit(
        NoInternetState(
          search: state.search,
          weather: state.weather,
          units: state.units,
        ),
      );
      return;
    }

    // Show loading screen
    emit(
      ShowLoading(
        units: state.units,
        weather: state.weather,
        message: 'Getting geolocation from City Name',
        search: state.search,
      ),
    );

    // Make request to get latitude and longitude by city name
    final eitherGeocoding =
        await _repository.loadWeatherByName(cityName: event.cityName);

    // Close loading screen
    emit(
      CloseLoading(
        units: state.units,
        weather: state.weather,
        search: state.search,
      ),
    );

    // Handle response to get latitude and longitude
    emit(
      eitherGeocoding.match(
        (failure) => WeatherFailure(
          failure: failure,
          units: (event.units ?? state.units),
          weather: state.weather,
          search: state.search,
        ),
        (geocoding) => WeatherGeocodingLoaded(
          geocoding: geocoding,
          units: (event.units ?? state.units),
          weather: state.weather,
          search: event.cityName,
        ),
      ),
    );

    // If latitude and longitude are obtained
    if (state is WeatherGeocodingLoaded) {
      // Trigger event to load weather data by latitude and longitude
      add(
        OnLoadByLatLonEvent(
          lat: (state as WeatherGeocodingLoaded).geocoding.lat,
          lon: (state as WeatherGeocodingLoaded).geocoding.lon,
          units: state.units,
        ),
      );
    }
  }

  /// Handler for loading weather data by GPS coordinates.
  void _onLoadByGPS(OnLoadByGPS event, Emitter<WeatherState> emit) async {
    // Show loading screen
    emit(
      ShowLoading(
        units: state.units,
        weather: state.weather,
        message: 'Getting location from GPS...',
        search: state.search,
      ),
    );

    // Get latitude and longitude by GPS
    final geolocator = await determinePosition();

    // Close loading screen
    emit(
      CloseLoading(
        units: state.units,
        weather: state.weather,
        search: '',
      ),
    );

    // Trigger event to load weather data by GPS coordinates
    add(
      OnLoadByLatLonEvent(
        lat: geolocator.latitude,
        lon: geolocator.longitude,
        units: state.units,
      ),
    );
  }
}
