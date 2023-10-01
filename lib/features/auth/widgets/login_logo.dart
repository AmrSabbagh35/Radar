import 'package:earthquake/constants/sizes.dart';
import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: sh * 0.37,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(70),
              bottomLeft: Radius.circular(70))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Center(
          child: Column(
            children: [
              Container(
                width: sw * 0.3,
                height: sh * 0.2,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: sh * 0.02,
              ),
              Text(
                'رادار',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: sh * 0.05,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
