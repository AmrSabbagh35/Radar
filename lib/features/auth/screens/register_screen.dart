import 'dart:io';

import 'package:earthquake/common/build_button.dart';
import 'package:earthquake/common/build_loading_animation.dart';
import 'package:earthquake/common/build_textfield.dart';
import 'package:earthquake/constants/colors.dart';
import 'package:earthquake/constants/sizes.dart';
import 'package:earthquake/features/auth/services/auth_provider.dart';
import 'package:earthquake/features/auth/services/location_provider.dart';
import 'package:earthquake/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? profileImage;

  final _signupFormKey = GlobalKey<FormState>();

  TextEditingController username = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController illness = TextEditingController();
  TextEditingController familyMembersNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordconfirm = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    fullname.dispose();
    email.dispose();
    phonenumber.dispose();
    age.dispose();
    location.dispose();
    illness.dispose();
    familyMembersNumber.dispose();
    password.dispose();
    passwordconfirm.dispose();
    super.dispose();
  }

  void selectprofileImage() async {
    var res = await pickImage();
    setState(() {
      profileImage = res;
    });
  }

  void signUpUser() async {
    context.read<AuthProvider>().signupUser(
          context: context,
          username: username.text,
          fullName: fullname.text,
          phoneNumber: phonenumber.text,
          address: location.text,
          age: int.parse(age.text),
          familyMembersNumber: int.parse(familyMembersNumber.text),
          email: email.text,
          profilePhoto: profileImage,
          password: password.text,
          illness: illness.text,
          lat: double.parse(context.read<LocationProvider>().lat),
          long: double.parse(context.read<LocationProvider>().long),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.watch<AuthProvider>().isLoading
          ? null
          : AppBar(
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
                'إنشاء حساب جديد',
                style: TextStyle(color: Colors.black),
              ),
            ),
      body: context.watch<AuthProvider>().isLoading
          ? const LoadingWidget()
          : GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Form(
                    key: _signupFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            label: 'الاسم الثلاثي',
                            c: fullname,
                            hinttext: 'اسمك الكامل',
                            maxchars: 20,
                            validator: (val) {
                              if (val!.isEmpty) return 'أدخل اسم صحيح';
                              return null;
                            },
                            inputtype: TextInputType.name),
                        CustomTextField(
                            label: 'اسم المستخدم',
                            c: username,
                            hinttext: 'اسم المستخدم',
                            maxchars: 20,
                            validator: (val) {
                              if (val!.isEmpty) return 'أدخل اسم صحيح';
                              return null;
                            },
                            inputtype: TextInputType.name),
                        CustomTextField(
                            label: 'العمر',
                            c: age,
                            hinttext: 'عمرك',
                            maxchars: 2,
                            validator: (val) {
                              if (val!.isEmpty) return 'أدخل عمرك';

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
                        CustomTextField(
                            label: 'عدد افراد العائلة',
                            c: familyMembersNumber,
                            hinttext: 'العدد',
                            maxchars: 2,
                            validator: (val) {
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
                              return null;
                            },
                            inputtype: TextInputType.multiline),
                        CustomTextField(
                            label: 'الأمراض',
                            hinttext:
                                'في حال كنت لا تعاني من أمراض اكتب لا يوجد',
                            c: illness,
                            maxlines: 3,
                            maxchars: 99,
                            validator: (val) {
                              return null;
                            },
                            inputtype: TextInputType.multiline),
                        SizedBox(
                          height: sh * 0.03,
                        ),
                        buildLocationButton(context),
                        CustomTextField(
                            label: 'كلمة السر',
                            c: password,
                            hinttext: '●●●●●●●●●●',
                            obsureText: true,
                            maxchars: 99,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "ادخل كلمة سر";
                              }
                              return null;
                            },
                            maxlines: 1,
                            inputtype: TextInputType.visiblePassword),
                        CustomTextField(
                            label: 'تأكيد كلمة السر',
                            obsureText: true,
                            c: passwordconfirm,
                            hinttext: '●●●●●●●●●●',
                            maxchars: 99,
                            validator: (val) {
                              if (val != password.text) {
                                return "كلمة السر غير مطابقة";
                              }
                              return null;
                            },
                            maxlines: 1,
                            inputtype: TextInputType.visiblePassword),
                        SizedBox(
                          height: sh * 0.05,
                        ),
                        CustomButton(
                            title: 'تسجيل',
                            callback: () {
                              if (_signupFormKey.currentState!.validate()) {
                                signUpUser();
                              }
                            },
                            color: primary)
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Column buildLocationButton(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: GestureDetector(
          onTap: context.read<LocationProvider>().getlocation,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: primary,
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                context.watch<LocationProvider>().isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Icon(
                        context.watch<LocationProvider>().sent
                            ? Icons.location_off
                            : Icons.location_on,
                        color: Colors.white,
                        size: sh * 0.05,
                      ),
                context.watch<LocationProvider>().isLoading
                    ? const SizedBox.shrink()
                    : Text(
                        context.watch<LocationProvider>().sent ? 'تم' : 'اضغط',
                        style: TextStyle(
                            fontSize: sh * 0.028, color: Colors.white),
                      ),
              ],
            )),
          ),
        )),
        SizedBox(
          height: sh * 0.05,
        ),
        context.watch<LocationProvider>().locationmessage == ''
            ? buildLoading()
            : buildMessages(),
        SizedBox(
          height: sh * 0.1,
        ),
      ],
    );
  }

  Column buildLoading() {
    return Column(
      children: const [
        CircularProgressIndicator(),
        SizedBox(
          height: 10,
        ),
        Text('يتم إرسال الموقع ...'),
      ],
    );
  }

  Column buildMessages() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          context.watch<LocationProvider>().sent
              ? 'تم تحديد الموقع'
              : 'اضغط على الزر و انتظر',
          style: TextStyle(fontSize: sh * 0.028, color: Colors.black),
        ),
      ],
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
