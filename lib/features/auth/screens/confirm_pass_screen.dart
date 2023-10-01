// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui' as ui;

import 'package:earthquake/common/build_loading_animation.dart';
import 'package:earthquake/common/build_textfield.dart';
import 'package:earthquake/features/auth/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:earthquake/common/build_button.dart';
import 'package:earthquake/common/build_text.dart';
import 'package:earthquake/constants/colors.dart';
import 'package:earthquake/constants/sizes.dart';
import 'package:earthquake/features/auth/widgets/build_timer.dart';
import 'package:provider/provider.dart';

class PinCodeScreen extends StatefulWidget {
  final String email;
  const PinCodeScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController pass = TextEditingController();
  String currentText = '';
  bool visible = false;

  void confirmpass() {
    context.read<AuthProvider>().confirmPass(
        email: widget.email,
        code: controller.text,
        context: context,
        newpassword: pass.text);
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'أدخل الرمز السري لتغيير كلمة السر',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: sh * 0.025,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: sh * 0.2,
                      ),
                      Directionality(
                        textDirection: ui.TextDirection.ltr,
                        child: PinCodeTextField(
                          length: 6,
                          appContext: context,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.fade,
                          cursorColor: primary,
                          pinTheme: PinTheme(
                              fieldOuterPadding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              shape: PinCodeFieldShape.underline,
                              selectedFillColor: primary,
                              activeColor: Colors.grey,
                              selectedColor: primary,
                              inactiveColor: Colors.grey),
                          animationDuration: const Duration(milliseconds: 300),
                          controller: controller,
                          autoUnfocus: true,
                          mainAxisAlignment: MainAxisAlignment.center,
                          onCompleted: (value) {
                            setState(() {
                              visible = true;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              currentText = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: sh * 0.05,
                      ),
                      const VerifyTimer(),
                      SizedBox(
                        height: sh * 0.04,
                      ),
                      Visibility(
                        visible: visible ? true : false,
                        child: CustomTextField(
                            label: 'كلمة السر الجديدة',
                            validator: (p0) {
                              return null;
                            },
                            c: pass,
                            hinttext: 'كلمةالسر الجديدة',
                            inputtype: TextInputType.visiblePassword),
                      ),
                      SizedBox(
                        height: sh * 0.2,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CustomText(
                          text: 'تغيير البريد الإلكتروني',
                          size: sh * 0.023,
                          weight: FontWeight.w500,
                          color: primary,
                        ),
                      ),
                      SizedBox(
                        height: sh * 0.05,
                      ),
                      CustomButton(
                        title: 'تأكيد الرمز',
                        callback: () {
                          print(widget.email);
                          print(controller.text);
                          print(pass.text);
                          confirmpass();
                        },
                        color: primary,
                      ),
                      SizedBox(
                        height: sh * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
