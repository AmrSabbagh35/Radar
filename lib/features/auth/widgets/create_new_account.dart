import 'package:earthquake/common/build_text.dart';
import 'package:earthquake/constants/colors.dart';
import 'package:earthquake/constants/sizes.dart';
import 'package:earthquake/features/auth/screens/register_screen.dart';
import 'package:flutter/material.dart';

class CreateNewAccount extends StatelessWidget {
  const CreateNewAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
            color: Colors.grey.shade800,
            text: 'ليس لديك حساب ؟ ',
            size: sh * 0.02,
            weight: FontWeight.normal),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterScreen()));
          },
          child: CustomText(
              color: primary,
              text: 'أنشأ حساباً جديداً !',
              size: sh * 0.02,
              weight: FontWeight.bold),
        ),
      ],
    );
  }
}
