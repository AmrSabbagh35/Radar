// ignore_for_file: use_build_context_synchronously

import 'package:earthquake/common/build_text.dart';
import 'package:earthquake/features/auth/services/location_provider.dart';
import 'package:earthquake/features/profile/services/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/sizes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
            icon: const Icon(Icons.location_searching),
            onPressed: () async {
              var lat = context.read<LocationProvider>().lat;
              var long = context.read<LocationProvider>().long;
              await context.read<LocationProvider>().getCurrentLocation();
              context
                  .read<ProfileProvider>()
                  .resendLocation(lat: lat, long: long, context: context);
            },
          ),
        )
      ],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: 'رادار',
            size: sh * 0.034,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
          SizedBox(
            width: sw * 0.02,
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
