// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:earthquake/common/build_text.dart';
import 'package:earthquake/constants/colors.dart';
import 'package:earthquake/constants/sizes.dart';
import 'package:url_launcher/url_launcher.dart';

class GoToLocationWidget extends StatelessWidget {
  final String long;
  final String lat;
  const GoToLocationWidget({
    Key? key,
    required this.long,
    required this.lat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final url = Uri.parse('https://maps.google.com?q=$lat,$long');
        launchUrl(url);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 6),
                    color: Colors.grey.withOpacity(.2),
                    blurRadius: 12)
              ],
              color: primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                    text: 'الذهاب الى الموقع',
                    size: sh * 0.023,
                    color: Colors.white,
                    weight: FontWeight.bold),
                SizedBox(
                  width: sw * 0.05,
                ),
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
