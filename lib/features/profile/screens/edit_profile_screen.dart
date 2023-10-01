import 'dart:io';

import 'package:earthquake/common/build_button.dart';
import 'package:earthquake/common/build_loading_animation.dart';
import 'package:earthquake/common/build_textfield.dart';
import 'package:earthquake/constants/colors.dart';
import 'package:earthquake/constants/sizes.dart';
import 'package:earthquake/features/profile/services/profile_provider.dart';
import 'package:earthquake/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final String username;
  final String fullname;
  final String email;
  final String phonenumber;
  final String age;
  final String location;
  final String illness;
  const EditProfileScreen({
    super.key,
    required this.username,
    required this.fullname,
    required this.email,
    required this.phonenumber,
    required this.age,
    required this.location,
    required this.illness,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? profileImage;

  TextEditingController username = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController illness = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    fullname.dispose();
    email.dispose();
    phonenumber.dispose();
    age.dispose();
    location.dispose();
    illness.dispose();
    super.dispose();
  }

  void selectprofileImage() async {
    var res = await pickImage();
    setState(() {
      profileImage = res;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        fullname = TextEditingController(text: widget.fullname);
        email = TextEditingController(text: widget.email);
        username = TextEditingController(text: widget.username);
        illness = TextEditingController(text: widget.illness);
        phonenumber = TextEditingController(text: widget.phonenumber);
        location = TextEditingController(text: widget.location);
        age = TextEditingController(text: widget.age);
      });
    });
  }

  void editProfile() {
    context.read<ProfileProvider>().editProfile(
        context: context,
        name: fullname.text,
        age: int.parse(age.text),
        illness: illness.text,
        address: location.text,
        phone: phonenumber.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: const Text(
          'تعديل الحساب',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: context.watch<ProfileProvider>().isLoading
            ? const LoadingWidget()
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: [
                      CustomTextField(
                          label: 'الاسم الثلاثي',
                          c: fullname,
                          hinttext: 'اسمك الكامل',
                          maxchars: 20,
                          validator: (val) {
                            if (!val!.isValidName) return 'أدخل اسم صحيح';
                            return null;
                          },
                          inputtype: TextInputType.name),
                      CustomTextField(
                          label: 'اسم المستخدم',
                          c: username,
                          hinttext: 'اسم المستخدم',
                          maxchars: 20,
                          enabled: false,
                          validator: (val) {
                            return null;
                          },
                          inputtype: TextInputType.name),
                      CustomTextField(
                          label: 'العمر',
                          c: age,
                          hinttext: 'عمرك',
                          maxchars: 2,
                          validator: (val) {
                            return null;
                          },
                          inputtype: TextInputType.number),
                      CustomTextField(
                          label: 'البريد الإلكتروني',
                          validator: (value) {
                            if (!value!.isValidEmail) {
                              return 'يرجى إرفاق بريد الكتروني صحيح';
                            }
                            return null;
                          },
                          c: email,
                          enabled: false,
                          hinttext: 'بريدك الإلكتروني',
                          inputtype: TextInputType.emailAddress),
                      CustomTextField(
                          label: 'رقم الموبايل',
                          c: phonenumber,
                          hinttext: 'الموبايل',
                          maxchars: 10,
                          validator: (val) {
                            if (!val!.isValidPhone) return 'ادخل رقما صحيحا';
                            return null;
                          },
                          inputtype: TextInputType.number),
                      buildEditPhoto(context),
                      CustomTextField(
                          label: 'العنوان الكامل',
                          hinttext: 'العنوان',
                          c: location,
                          maxlines: 3,
                          maxchars: 99,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'ادخل عنوانك الكامل';
                            }
                            return null;
                          },
                          inputtype: TextInputType.multiline),
                      CustomTextField(
                          label: 'الأمراض',
                          hinttext: 'في حال كنت لا تعاني من أمراض اكتب لا يوجد',
                          c: illness,
                          maxlines: 3,
                          maxchars: 99,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'ادخل عنوانك الكامل';
                            }
                            return null;
                          },
                          inputtype: TextInputType.multiline),
                      SizedBox(
                        height: sh * 0.05,
                      ),
                      CustomButton(
                          title: 'تعديل الحساب',
                          callback: () {
                            editProfile();
                          },
                          color: primary)
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Center buildEditPhoto(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: profileImage != null
                    ? Image.file(
                        profileImage!,
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                      )
                    : Image.asset(
                        'assets/images/avatar.jpg',
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                      ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 4,
              child: buildCircle(
                color: Colors.white,
                pad: 3.0,
                child: buildCircle(
                    color: primary,
                    pad: 10.0,
                    child: InkWell(
                      onTap: selectprofileImage,
                      child: const Icon(
                        Icons.add_a_photo,
                        size: 20,
                        color: Colors.white,
                      ),
                    )),
              )),
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
