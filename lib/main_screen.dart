import 'package:earthquake/constants/colors.dart';
import 'package:earthquake/constants/sizes.dart';
import 'package:earthquake/features/emergency/screens/emergency_screen.dart';
import 'package:earthquake/features/home/screens/home_screen.dart';
import 'package:earthquake/features/profile/screens/profile_screen.dart';
import 'package:earthquake/features/tools/screens/tools_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const EmergencyScreen(),
      const ToolsScreen(),
      const ProfileScreen(),
    ];

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          iconSize: 30,
          title: ("الرئيسية"),
          textStyle: TextStyle(fontSize: sh * 0.02),
          activeColorPrimary: primary,
          inactiveIcon: const Icon(Icons.home_outlined),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.article),
          iconSize: 30,
          title: ("مقالات"),
          textStyle: TextStyle(fontSize: sh * 0.02),
          activeColorPrimary: primary,
          inactiveIcon: const Icon(Icons.emergency_outlined),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(FontAwesomeIcons.toolbox),
          iconSize: 25,
          title: ("الأدوات"),
          textStyle: TextStyle(fontSize: sh * 0.02),
          activeColorPrimary: primary,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          iconSize: 30,
          title: ("حسابي"),
          textStyle: TextStyle(fontSize: sh * 0.02),
          activeColorPrimary: primary,
          inactiveIcon: const Icon(Icons.person_outline),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      stateManagement: true,
      controller: controller,
      screens: screens,
      items: navBarsItems(),
      // confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.

      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.black,
      ),

      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),

      // screenTransitionAnimation: const ScreenTransitionAnimation(
      //   // Screen transition animation on change of selected tab.
      //   animateTabTransition: true,
      //   curve: Curves.ease,
      //   duration: Duration(milliseconds: 200),
      // ),
      navBarStyle:
          NavBarStyle.style9, // Choose the nav bar style with this property.
    );
  }
}
