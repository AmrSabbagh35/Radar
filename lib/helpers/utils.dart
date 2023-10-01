import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void showSnackBar(BuildContext context, String text) {
  Fluttertoast.showToast(msg: text, toastLength: Toast.LENGTH_LONG);
}

Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  debugPrint(prefs.getString("access-token"));
  return prefs.getString("access-token");
}

Future<String?> getRefreshToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("refresh-token");
}

void launchPhone(String phoneNumber) async {
  final telUrl = 'tel:$phoneNumber';
  if (await canLaunch(telUrl)) {
    await launch(telUrl);
  } else {
    throw Fluttertoast.showToast(msg: 'فشل الاتصال ب $phoneNumber');
  }
}

Future<File?> pickImage() async {
  File? image;
  try {
    var file = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (file != null && file.files.isNotEmpty) {
      image = File(file.files.first.path!);
    }
  } catch (err) {
    debugPrint(err.toString());
  }
  return image;
}
