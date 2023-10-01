import 'package:earthquake/features/emergency/screens/instructions_screen.dart';
import 'package:earthquake/features/emergency/widgets/build_option.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('مقالات'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmergencyOption(
                  image: 'assets/images/instructions.jpg',
                  icon: Icons.abc,
                  callback: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: const InstructionsScreen(), withNavBar: false);
                  },
                  text: 'كيف نحمي أنفسنا عند حدوث زلزال ؟'),
              EmergencyOption(
                  image: 'assets/images/article.jpeg',
                  icon: Icons.abc,
                  callback: () {
                    launchUrl(
                        mode: LaunchMode.inAppWebView,
                        Uri.parse(
                            'https://www.dw.com/ar/%D8%B2%D9%84%D8%B2%D8%A7%D9%84-%D8%AA%D8%B1%D9%83%D9%8A%D8%A7-%D9%88%D8%B3%D9%88%D8%B1%D9%8A%D8%A7-%D8%AD%D8%B5%D9%8A%D9%84%D8%A9-%D8%A7%D9%84%D9%83%D8%A7%D8%B1%D8%AB%D8%A9-%D9%88%D8%AA%D8%AF%D8%A7%D8%B9%D9%8A%D8%A7%D8%AA%D9%87%D8%A7-%D8%A8%D8%A7%D9%84%D8%AA%D9%81%D8%A7%D8%B5%D9%8A%D9%84-%D9%88%D8%A7%D9%84%D8%A3%D8%B1%D9%82%D8%A7%D9%85/a-64910971'));
                  },
                  text:
                      'زلزال تركيا وسوريا.. حصيلة الكارثة وتداعياتها بالتفاصيل والأرقام'),
              EmergencyOption(
                  image: 'assets/images/meter.jpg',
                  icon: Icons.abc,
                  callback: () {
                    launchUrl(
                        mode: LaunchMode.inAppWebView,
                        Uri.parse(
                            'https://www.aljazeera.net/tech/2017/11/30/%D9%87%D9%84-%D8%A3%D8%B5%D8%A8%D8%AD-%D8%A7%D9%84%D8%AA%D9%86%D8%A8%D8%A4-%D8%A8%D8%A7%D9%84%D8%B2%D9%84%D8%A7%D8%B2%D9%84-%D9%85%D9%85%D9%83%D9%86%D8%A7'));
                  },
                  text: 'هل أصبح توقع الزلازل ممكنا باستخدام الذكاء الصنعي ؟'),
            ],
          ),
        ),
      ),
    );
  }
}
