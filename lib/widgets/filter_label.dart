import 'package:flutter/material.dart';

class FilterLabel extends StatelessWidget {
  const FilterLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        color: color,
        fontSize: 10,
        fontWeight: FontWeight.w900,
        letterSpacing: .9,
      ),
    );
  }
}
