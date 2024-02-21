/// Represents weather data including location and current weather conditions.
class EWeather {
  const EWeather({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.current,
  });

  final double lat; // Latitude coordinate
  final double lon; // Longitude coordinate
  final String timezone; // Timezone name
  final Current current; // Current weather data

  /// Constructs an instance of [EWeather] from a JSON map.
  factory EWeather.fromJson(Map<String, dynamic> json) => EWeather(
        lat: json["lat"]?.toDouble() ?? 0.0,
        lon: json["lon"]?.toDouble() ?? 0.0,
        timezone: json["timezone"] ?? '',
        current: Current.fromJson(json["current"] ?? {}),
      );

  /// Converts this [EWeather] instance to a JSON map.
  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
        "current": current.toJson(),
      };
}

/// Represents the current weather conditions.
class Current {
  const Current({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.weather,
  });

  final double temp; // Current temperature
  final double feelsLike; // Current temperature feels like
  final int humidity; // Humidity
  final double windSpeed; // Wind speed
  final List<Weather> weather; // Weather condition details

  /// Constructs an instance of [Current] from a JSON map.
  factory Current.fromJson(Map<String, dynamic> json) => Current(
          temp: json["temp"]?.toDouble() ?? 0.0,
          feelsLike: json["feels_like"]?.toDouble() ?? 0.0,
          humidity: json["humidity"] ?? 0,
          windSpeed: json["wind_speed"]?.toDouble() ?? 0.0,
          weather: [
            for (var item in json["weather"] ?? []) Weather.fromJson(item ?? {})
          ]);

  /// Converts this [Current] instance to a JSON map.
  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "humidity": humidity,
        "wind_speed": windSpeed,
        "weather": List<Weather>.from(weather.map((x) => x.toJson())),
      };
}

/// Represents weather condition details.
class Weather {
  const Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int id; // Weather condition ID
  final String main; // Weather main description
  final String description; // Weather description
  final String icon; // Weather icon ID

  /// Constructs an instance of [Weather] from a JSON map.
  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"] ?? -1,
        main: json["main"] ?? '',
        description: json["description"] ?? '',
        icon: json["icon"] ?? '',
      );

  /// Converts this [Weather] instance to a JSON map.
  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

/// Represents the unit type for temperature.
enum UnitsType { celsius, fahrenheit }
