import 'package:earthquake/common/build_button.dart';
import 'package:earthquake/common/build_loading_animation.dart';
import 'package:earthquake/common/build_textfield.dart';
import 'package:earthquake/constants/colors.dart';
import 'package:earthquake/constants/sizes.dart';
import 'package:earthquake/features/auth/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController oldpass = TextEditingController();
  TextEditingController newpass = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    oldpass.dispose();
    newpass.dispose();
    super.dispose();
  }

  resetPass() {
    context.read<AuthProvider>().resetPass(
        context: context,
        email: email.text,
        oldpass: oldpass.text,
        newpassword: newpass.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('تغيير كلمة السر'),
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
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
                          label: 'كلمة السر القديمة',
                          validator: (value) {
                            return null;
                          },
                          c: oldpass,
                          hinttext: 'كلمة السر القديمة',
                          obsureText: true,
                          inputtype: TextInputType.visiblePassword),
                      CustomTextField(
                          label: 'كلمة السر الجديدة',
                          validator: (value) {
                            return null;
                          },
                          c: newpass,
                          hinttext: 'كلمة السر الجديدة',
                          obsureText: true,
                          inputtype: TextInputType.visiblePassword),
                      SizedBox(
                        height: sh * 0.4,
                      ),
                      CustomButton(
                          title: 'تغيير كلمة السر',
                          callback: () {
                            resetPass();
                          },
                          color: primary)
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
