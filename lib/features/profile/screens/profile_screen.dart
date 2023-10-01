import 'package:earthquake/common/build_button.dart';
import 'package:earthquake/common/build_text.dart';
import 'package:earthquake/common/custom_dialog.dart';
import 'package:earthquake/constants/colors.dart';
import 'package:earthquake/constants/sizes.dart';
import 'package:earthquake/features/auth/services/auth_provider.dart';
import 'package:earthquake/features/profile/screens/edit_profile_screen.dart';
import 'package:earthquake/features/profile/screens/reset_pass_screen.dart';
import 'package:earthquake/features/profile/services/profile_provider.dart';
import 'package:earthquake/features/profile/widgets/build_profile_button.dart';
import 'package:earthquake/features/profile/widgets/profile_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../../common/build_loading_animation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<ProfileProvider>().getProfileInfo(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var profile = context.read<ProfileProvider>().profile;
    var user = context.read<ProfileProvider>().user;
    var auth = context.read<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              auth.signOut(context: context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            )),
      ),
      body: context.watch<ProfileProvider>().isLoading
          ? const LoadingWidget()
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: buildEditPhoto(
                          context: context,
                          image: profile.image,
                          username: user.username),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileButton(
                            text: 'تعديل الحساب',
                            callback: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: EditProfileScreen(
                                  username: user.username,
                                  fullname: utf8
                                      .decode(profile.fullName.runes.toList()),
                                  email: user.email,
                                  phonenumber: profile.phone,
                                  age: profile.age.toString(),
                                  location: utf8
                                      .decode(profile.address.runes.toList()),
                                  illness: utf8
                                      .decode(profile.illnesses.runes.toList()),
                                ),
                                withNavBar: false,
                              );
                            },
                            icon: Icons.edit_outlined),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sh * 0.05,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    height: sh * 0.02,
                  ),
                  ProfileListTile(
                    icon: Icons.person,
                    title: 'الاسم الكامل',
                    subtitle: utf8.decode(profile.fullName.runes.toList()),
                  ),
                  ProfileListTile(
                    icon: Icons.email,
                    title: 'البريد الإلكتروني',
                    subtitle: user.email,
                  ),
                  ProfileListTile(
                    icon: Icons.phone,
                    title: 'رقم الموبايل',
                    subtitle: profile.phone,
                  ),
                  ProfileListTile(
                    icon: FontAwesomeIcons.locationDot,
                    title: 'العنوان',
                    subtitle: utf8.decode(profile.address.runes.toList()),
                  ),
                  ProfileListTile(
                    icon: FontAwesomeIcons.cakeCandles,
                    title: 'العمر',
                    subtitle: '${profile.age} سنة',
                  ),
                  ProfileListTile(
                    icon: FontAwesomeIcons.fileMedical,
                    title: 'الأمراض',
                    subtitle: utf8.decode(profile.illnesses.runes.toList()),
                  ),
                  ProfileListTile(
                    icon: Icons.family_restroom,
                    title: 'عدد أفراد العائلة',
                    subtitle: profile.familyMembers.toString(),
                  ),
                  buildButton(
                      context: context,
                      text: 'تغيير كلمة السر',
                      callback: () => PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const ResetPassScreen(),
                            withNavBar: false,
                          )),
                  buildButton(
                      context: context,
                      text: 'حذف الحساب',
                      callback: () => showDialog(
                          context: context,
                          builder: (context) => CustomDialog(
                                title: 'حذف الحساب',
                                content:
                                    const Text('هل انت متأكد من حذف الحساب ؟'),
                                options: true,
                              ))),
                ],
              ),
            ),
    );
  }

  Container buildButton({context, text, callback}) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade200,
      height: sh * 0.15,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: SizedBox(
          width: sw * 0.8,
          child: CustomButton(title: text, callback: callback, color: primary),
        ),
      ),
    );
  }

  Center buildEditPhoto({context, image, username}) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child:
                    // CachedNetworkImage(
                    //   imageUrl: image,
                    //   fit: BoxFit.cover,
                    //   width: 120,
                    //   height: 120,
                    // ),
                    Image.asset(
                  'assets/images/avatar.jpg',
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                ),
              ),
            ),
          ),
          SizedBox(
            height: sh * 0.02,
          ),
          CustomText(text: username, size: sh * 0.03, weight: FontWeight.bold)
        ],
      ),
    );
  }

  Widget buildCircle({pad, child, color}) {
    return ClipOval(
      child:
          Container(color: color, padding: EdgeInsets.all(pad), child: child),
    );
  }
}
