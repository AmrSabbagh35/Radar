// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:earthquake/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  final Color color;
  const CustomButton({
    Key? key,
    required this.title,
    required this.callback,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: GestureDetector(
        onTap: callback,
        child: Container(
          width: double.infinity,
          height: sh * 0.07,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(20)),
          child: Center(
              child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: sh * 0.026,
                fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
