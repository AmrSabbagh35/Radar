// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:earthquake/common/build_button.dart';
import 'package:earthquake/common/build_loading_animation.dart';
import 'package:earthquake/common/build_text.dart';
import 'package:earthquake/common/build_textfield.dart';
import 'package:earthquake/constants/colors.dart';
import 'package:earthquake/constants/sizes.dart';
import 'package:earthquake/features/auth/screens/forgot_pass_screen.dart';
import 'package:earthquake/features/auth/services/auth_provider.dart';
import 'package:earthquake/features/auth/widgets/create_new_account.dart';
import 'package:earthquake/features/auth/widgets/login_logo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _signinFormKey = GlobalKey<FormState>();
  TextEditingController usercontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  String? FCMtoken;

  @override
  void dispose() {
    usercontroller.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  void signInUser() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.getToken().then((token) {
      FCMtoken = token;
    });
    context.read<AuthProvider>().signIn(
        context: context,
        username: usercontroller.text,
        password: passcontroller.text,
        fcmtoken: FCMtoken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LoginLogo(),
                    SizedBox(
                      height: sh * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _signinFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'الحقل فارغ';
                                  }
                                  return null;
                                },
                                label: 'اسم المستخدم',
                                c: usercontroller,
                                hinttext: 'اسم المستخدم',
                                inputtype: TextInputType.name),
                            SizedBox(
                              height: sh * 0.01,
                            ),
                            CustomTextField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'الحقل فارغ';
                                  }
                                  return null;
                                },
                                label: 'كلمة المرور',
                                obsureText: true,
                                c: passcontroller,
                                hinttext: 'كلمة المرور',
                                inputtype: TextInputType.visiblePassword),
                            SizedBox(
                              height: sh * 0.01,
                            ),
                            buildForgotPass(context),
                            SizedBox(
                              height: sh * 0.05,
                            ),
                            CustomButton(
                                title: 'تسجيل الدخول',
                                callback: () {
                                  if (_signinFormKey.currentState!.validate()) {
                                    signInUser();
                                  }
                                },
                                color: primary),
                            SizedBox(
                              height: sh * 0.06,
                            ),
                            const CreateNewAccount()
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildForgotPass(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ForgotPassScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 0, right: 10, bottom: 20),
        child: CustomText(
            text: 'نسيت كلمة السر ؟',
            size: 15,
            color: primary,
            weight: FontWeight.bold),
      ),
    );
  }
}
