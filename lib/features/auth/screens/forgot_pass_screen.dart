import 'package:earthquake/common/build_button.dart';
import 'package:earthquake/common/build_loading_animation.dart';
import 'package:earthquake/common/build_text.dart';
import 'package:earthquake/common/build_textfield.dart';
import 'package:earthquake/constants/colors.dart';
import 'package:earthquake/constants/sizes.dart';
import 'package:earthquake/features/auth/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  TextEditingController email = TextEditingController();

  forgotPass() {
    context
        .read<AuthProvider>()
        .forgotPass(email: email.text, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('استعادة كلمة السر'),
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
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomText(
                            text: 'هل نسيت كلمة السر ؟ ',
                            size: sh * 0.03,
                            weight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: CustomText(
                            text:
                                'أدخل البريد الإلكتروني الخاص بك ليتم إرسال رمز تغيير كلمة السر',
                            size: sh * 0.023,
                            color: Colors.black87,
                            weight: FontWeight.normal),
                      ),
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
                      SizedBox(
                        height: sh * 0.5,
                      ),
                      CustomButton(
                          title: 'ارسال الرمز',
                          callback: () {
                            forgotPass();
                          },
                          color: primary),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
