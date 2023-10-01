import 'dart:ui';
import 'package:earthquake/constants/sizes.dart';
import 'package:earthquake/features/tools/screens/recording_screen.dart';
import 'package:earthquake/features/tools/screens/health_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildOption(
                  text: 'أداة معلومات الساعة الذكية',
                  image: 'assets/images/watch.png',
                  callback: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: HealthApp(), withNavBar: false);
                  }),
              buildOption(
                  text: 'أداة إرسال رسالة طوارئ',
                  image: 'assets/images/emergency.jpg',
                  callback: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: const VoiceRecordingScreen(),
                        withNavBar: false);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOption({image, text, callback}) {
    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: double.infinity,
          height: sh * 0.3,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 6),
                color: Colors.grey.withOpacity(.2),
                blurRadius: 12,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
