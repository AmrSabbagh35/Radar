import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color color;

  const CustomText(
      {super.key,
      required this.text,
      required this.size,
      required this.weight,
      this.color = Colors.black});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: size, fontWeight: weight, color: color),
    );
  }
}
