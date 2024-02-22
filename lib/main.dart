import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/common/theme.dart';
import 'package:weather_app/src/weather/module.dart';

void main() async {
  /// Loads environment variables from a .env file into your root of Flutter application.
  /// Example of file .env:
  /// API_WEATHER_KEY=TU_CLAVE_API

  await dotenv.load();

  runApp(
    ///Modular architecture, routing, and dependency injection setup.
    ModularApp(
      module: WeatherModule(envInstance: dotenv),
      child: const RootWidget(),
    ),
  );
}

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /// Modular architecture,
    Modular.setInitialRoute('/');
    return ChangeNotifierProvider(
      create: (context) => ColorSchemeProvider(
        initialColorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      child: Consumer<ColorSchemeProvider>(builder: (context, provider, child) {
        return MaterialApp.router(
          title: 'Weather App',
          theme: ThemeData.light().copyWith(
            // Define the default brightness and colors.
            colorScheme: provider.colorScheme,
          ),
          routerConfig: Modular.routerConfig,
        );
      }),
    ); //added by extension
  }
}
