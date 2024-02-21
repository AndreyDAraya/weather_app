part of '../page.dart';

/// Widget for displaying an option card with a label, value, and icon of bottom weather information.
class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        DsVerticalSpace.sl,
        Text(
          label,
          style: const TextStyle(
            fontSize: DsSpace.sl,
            fontWeight: FontWeight.bold,
          ),
        ),
        DsVerticalSpace.sl,
        Text(
          value,
          style: const TextStyle(
            fontSize: DsSpace.xl,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
