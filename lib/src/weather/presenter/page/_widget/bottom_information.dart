part of '../page.dart';

/// Widget for displaying bottom weather information.
class BottomInformationWidget extends StatelessWidget {
  const BottomInformationWidget({
    required this.unit, // Unit type for weather information
    super.key,
    this.wind = '0', // Wind speed
    this.humidity = '0', // Humidity percentage
    this.sessation = '0', // Sensation temperature
    this.symbol = '', // Symbol for temperature unit
  });

  final String wind; // Wind speed
  final String humidity; // Humidity percentage
  final String sessation; // Sensation temperature
  final String symbol; // Symbol for temperature unit

  final UnitsType unit; // Unit type for weather information

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DsSpace.md), // Padding for the container
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DsSpace.lg), // Rounded corners
        color: Theme.of(context).colorScheme.inversePrimary, // Background color
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OptionCard(
                label: 'SESSATION', // Label for sensation temperature
                value: '$sessation$symbol', // Value for sensation temperature
                icon: Icons.sunny, // Icon for sensation temperature
              ),
              OptionCard(
                label: 'WIND', // Label for wind speed
                value: wind +
                    ((UnitsType.celsius == unit)
                        ? 'm/s'
                        : 'm/h'), // Value for wind speed
                icon: Icons.air, // Icon for wind speed
              ),
              OptionCard(
                label: 'HUMIDITY', // Label for humidity percentage
                value: '$humidity%', // Value for humidity percentage
                icon: Icons.thermostat, // Icon for humidity percentage
              ),
            ],
          )
        ],
      ),
    );
  }
}
