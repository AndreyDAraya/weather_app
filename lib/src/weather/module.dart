import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_app/src/utils/utils.dart';
import 'package:weather_app/src/weather/data/data.dart';
import 'package:weather_app/src/weather/domain/domain.dart';
import 'package:weather_app/src/weather/presenter/bloc/weather_bloc.dart';
import 'package:weather_app/src/weather/presenter/presenter.dart';

/// Module for weather-related dependencies and routing.
class WeatherModule extends Module {
  WeatherModule({required this.envInstance});

  final DotEnv envInstance;

  @override
  void binds(i) {
    ///Dependencie that Getting Enviroment Variablesz`
    i.addSingleton(() => envInstance);

    ///Dependencie Injection for HTTP request
    i.addSingleton(MsDio.new);

    ///Dependencie Injection for WeatherRepository DOMAIN
    i.addSingleton<WeatherRepository>(ApiWeather.new);

    ///Dependencie Injection for BloC (Management State)
    i.addSingleton(WeatherBloc.new);
  }

  @override
  void routes(r) {
    /// Root page WeatherPage
    r.child(
      '/',
      child: (context) => const WeatherPage(),
    );
  }
}
