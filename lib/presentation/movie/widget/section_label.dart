import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  final String label;
  final EdgeInsetsGeometry margin;

  const SectionLabel(
    this.label, {
    super.key,
    this.margin = const EdgeInsets.symmetric(vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
