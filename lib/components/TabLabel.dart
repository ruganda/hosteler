import 'package:flutter/material.dart';

class TabLabel extends StatelessWidget {
  const TabLabel({
    this.label,
    this.color,
    this.align
  });

  final String? label;
  final Color? color;
  final Alignment? align;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 0.0),
      alignment: align,
      child: Text(
        label!,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          color: color,
        ),
      ),
    );
  }
}
