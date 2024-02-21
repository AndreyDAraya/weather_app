import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/common/theme.dart';
import 'package:weather_app/src/weather/module.dart';

void main() {
  runApp(
    ///Modular architecture, routing, and dependency injection setup.
    ModularApp(
      module: WeatherModule(),
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
