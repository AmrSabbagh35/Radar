import 'package:earthquake/common/build_text.dart';
import 'package:earthquake/constants/colors.dart';
import 'package:earthquake/features/home/widgets/go_to_location.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/sizes.dart';

class RecentCard extends StatelessWidget {
  final String? place;
  final String? mag;
  final String? time;
  final String? depth;
  final String? long;
  final String? lat;
  final DateTime? days;
  const RecentCard({
    super.key,
    required this.place,
    required this.mag,
    required this.time,
    required this.depth,
    required this.long,
    required this.lat,
    this.days,
  });

  @override
  Widget build(BuildContext context) {
    String getElapsedTime() {
      final serverTimeDifference =
          Duration(hours: 3); // Adjust this according to the time difference

      final now = DateTime.now().subtract(serverTimeDifference);
      final difference = now.difference(days!);

      if (difference.inDays > 1) {
        return '${difference.inDays} أيام';
      } else if (difference.inDays == 1) {
        return 'يوم واحد';
      } else if (difference.inDays == 2) {
        return 'يومين';
      } else if (difference.inHours >= 1) {
        return '${difference.inHours} ساعات';
      } else if (difference.inHours == 1) {
        return 'ساعة';
      } else if (difference.inMinutes >= 60) {
        return '${difference.inMinutes} دقيقة';
      } else {
        return 'أقل من دقيقة';
      }
    }

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: Colors.grey.withOpacity(.2),
              blurRadius: 12)
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: mag ?? 'لا يوجد معلومات',
                      size: sh * 0.03,
                      weight: FontWeight.bold,
                      color: Colors.red.shade800,
                    ),
                    CustomText(
                      // text: days == '1'
                      //     ? 'منذ 24 ساعة'
                      //     : days == '2'
                      //         ? 'منذ يومين'
                      //         : 'منذ $days أيام',
                      text: getElapsedTime(),
                      size: sh * 0.03,
                      weight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ],
                ),
                SizedBox(
                  height: sh * 0.01,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: place ?? 'لا يوجد معلومات',
                        size: sh * 0.025,
                        weight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: sw * 0.04,
                    ),
                    const Icon(
                      FontAwesomeIcons.earthAsia,
                      color: Colors.black,
                    )
                  ],
                ),
                SizedBox(
                  height: sh * 0.01,
                ),
                Row(
                  children: [
                    CustomText(
                      text: 'العمق : $depth',
                      size: sh * 0.025,
                      weight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: sw * 0.04,
                    ),
                    const Icon(
                      FontAwesomeIcons.squareCaretDown,
                      color: Colors.black,
                    )
                  ],
                ),
                SizedBox(
                  height: sh * 0.01,
                ),
                Row(
                  children: [
                    CustomText(
                      text: 'التاريخ : $time',
                      size: sh * 0.025,
                      weight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: sw * 0.04,
                    ),
                    const Icon(
                      Icons.timer_outlined,
                      color: Colors.black,
                    )
                  ],
                ),
                SizedBox(
                  height: sh * 0.05,
                ),
                GoToLocationWidget(long: long.toString(), lat: lat.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
