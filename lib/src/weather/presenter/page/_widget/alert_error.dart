part of '../page.dart';

/// Widget for displaying an alert error message.
class _AlertError extends StatelessWidget {
  const _AlertError();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'City not found. Please try with a different city.',
      style: TextStyle(
        color: Colors.red, // Text color
        fontWeight: FontWeight.bold, // Bold font weight
        fontSize: DsSpace.md, // Medium font size
      ),
    );
  }
}
