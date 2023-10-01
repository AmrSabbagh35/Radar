import 'package:earthquake/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ProfileListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: ListTile(
        leading: Icon(
          icon,
          color: primary,
          size: 30,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
