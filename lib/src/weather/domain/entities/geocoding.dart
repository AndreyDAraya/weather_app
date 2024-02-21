/// Represents geocoding data containing latitude and longitude coordinates.
class EGeocoding {
  /// Constructs an instance of [EGeocoding].
  const EGeocoding({
    required this.lat, // Latitude coordinate
    required this.lon, // Longitude coordinate
  });

  /// Latitude coordinate.
  final double lat;

  /// Longitude coordinate.
  final double lon;

  /// Constructs an instance of [EGeocoding] from a JSON map.
  factory EGeocoding.fromJson(Map<String, dynamic> json) => EGeocoding(
        lat: json["lat"]?.toDouble(), // Extracting latitude from JSON
        lon: json["lon"]?.toDouble(), // Extracting longitude from JSON
      );

  /// Converts this [EGeocoding] instance to a JSON map.
  Map<String, dynamic> toJson() => {
        "lat": lat, // Adding latitude to JSON
        "lon": lon, // Adding longitude to JSON
      };
}
