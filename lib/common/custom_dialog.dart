// ignore_for_file: must_be_immutable

import 'package:earthquake/constants/colors.dart';
import 'package:earthquake/features/profile/services/profile_provider.dart';
import 'package:earthquake/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final Widget content;
  bool options;

  CustomDialog(
      {Key? key,
      required this.title,
      required this.content,
      this.options = false})
      : super(key: key);
  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(widget.title),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
      actionsOverflowButtonSpacing: 20,
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primary)),
            onPressed: () {
              context.read<ProfileProvider>().deleteProfile(context: context);
            },
            child: widget.options ? const Text("نعم") : const Text("لا")),
        widget.options
            ? ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primary)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("الرجوع"))
            : const SizedBox(),
      ],
      content: widget.content,
    );
  }
}
