import 'package:dio/dio.dart';

/// Wrapper class for Dio HTTP client.
class MsDio {
  /// Returns an instance of Dio configured with base URL for OpenWeatherMap API.
  Dio get dio => Dio(
        BaseOptions(baseUrl: 'https://api.openweathermap.org'),
      );
}
