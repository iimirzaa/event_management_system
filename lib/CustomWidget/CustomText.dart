import 'package:flutter/material.dart';
class CustomText extends StatelessWidget {
  final String text;
  final FontWeight weight;
  final Color color;
  final double ?size;
  final FontStyle? style;
  const CustomText({super.key,
  required this.text,
  required this.color,
  required this.weight,
  this.size,
  this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        fontStyle: style,
        color: color,


      ),

    );
  }
}
