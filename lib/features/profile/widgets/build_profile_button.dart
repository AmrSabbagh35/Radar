// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:earthquake/constants/sizes.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final IconData icon;

  const ProfileButton({
    Key? key,
    required this.text,
    required this.callback,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Material(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: sw * 0.3,
            height: sh * 0.09,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red[400]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: sh * 0.04, color: Colors.white),
                SizedBox(
                  width: sw * 0.02,
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: sh * 0.024,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
