// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../constants/sizes.dart';
import 'build_text.dart';

class BuildTitle extends StatelessWidget {
  final String title;
  const BuildTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomText(text: title, size: sh * 0.035, weight: FontWeight.bold),
    );
  }
}
