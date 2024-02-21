part of '../page.dart';

/// Widget for displaying bottom navigation bar.
class _BottomNavigationWidget extends StatelessWidget {
  const _BottomNavigationWidget({
    required this.state, // Current state of the weather
  });

  final WeatherState state; // Current state of the weather

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: state.units.index, // Current index based on units type
      onTap: (index) {
        var intValue = Random().nextInt(6);
        BlocProvider.of<WeatherBloc>(context).add(
          OnLoadByLatLonEvent(
            lat: state.weather.lat, // Latitude
            lon: state.weather.lon, // Longitude
            units:
                UnitsType.values[index], // Units type based on selected index
          ),
        );

        Provider.of<ColorSchemeProvider>(context, listen: false)
            .updateColorScheme(
          ColorScheme.fromSeed(
            seedColor: getColor(intValue),
          ),
        );
      },
      items: const [
        BottomNavigationBarItem(
          label: '°C', // Label for Celsius
          icon: Icon(Icons.thermostat), // Icon for Celsius
          tooltip: 'Change to Celsius', // Tooltip for Celsius
        ),
        BottomNavigationBarItem(
          label: '°F', // Label for Fahrenheit
          icon: Icon(Icons.thermostat), // Icon for Fahrenheit
          tooltip: 'Change to Fahrenheit', // Tooltip for Fahrenheit
        ),
      ],
    );
  }

  Color getColor(int i) {
    final color = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.black,
    ][i];

    return color;
  }
}
