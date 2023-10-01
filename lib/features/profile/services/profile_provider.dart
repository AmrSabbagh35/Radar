import 'dart:convert';
import 'dart:io';

import 'package:earthquake/constants/consts.dart';
import 'package:earthquake/helpers/error_handling.dart';
import 'package:earthquake/helpers/utils.dart';
import 'package:earthquake/models/profile.dart';
import 'package:earthquake/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Profile profile = Profile(
      id: 0,
      phone: '',
      fullName: '',
      age: 0,
      image: '',
      familyMembers: 0,
      address: '',
      illnesses: '',
      latitude: 0,
      longitude: 0);

  User user = User(username: '', email: '');

  getProfileInfo({context}) async {
    var token = await getToken();
    try {
      isLoading = true;
      http.Response res = await http
          .get(Uri.parse('$baseUrl/users/profile/'), headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            user = User.fromJson(jsonDecode(res.body)['user']);
            profile = Profile.fromJson(jsonDecode(res.body)['profile']);
            debugPrint(profile.toJson().toString());
            debugPrint(user.toJson().toString());
            isLoading = false;
          },
          onFailed: () {
            isLoading = false;
          });
    } on SocketException {
      isLoading = false;
      showSnackBar(context, 'لا يوجد اتصال انترنت');
    } catch (e) {
      showSnackBar(context, e.toString());
      isLoading = false;
    }
  }

  void editProfile({
    context,
    phone,
    age,
    name,
    address,
    illness,
  }) async {
    var token = await getToken();
    try {
      isLoading = true;
      http.Response res = await http.put(Uri.parse('$baseUrl/users/profile/'),
          body: jsonEncode({
            'phone': phone,
            'age': age,
            'full_name': name,
            'address': address,
            'illnesses': illness
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer $token",
          });

      httpErrorHandler(
        response: res,
        context: context,
        onFailed: () {
          isLoading = false;
        },
        onSuccess: () async {
          getProfileInfo(context: context);
          isLoading = false;
          Navigator.pop(context);
        },
      );
    } on SocketException {
      showSnackBar(context, 'لا يوجد اتصال انترنت');
      isLoading = false;
    } catch (e) {
      showSnackBar(context, e.toString());
      isLoading = false;
    }
  }

  resendLocation({context, long, lat}) async {
    var token = await getToken();
    try {
      isLoading = true;
      http.Response res = await http.put(Uri.parse('$baseUrl/users/profile/'),
          body: jsonEncode({
            'lat': lat,
            'long': long,
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer $token",
          });

      httpErrorHandler(
        response: res,
        context: context,
        onFailed: () {
          isLoading = false;
        },
        onSuccess: () async {
          showSnackBar(context, 'تم ارسال الموقع مرة أخرى');
          isLoading = false;
        },
      );
    } on SocketException {
      showSnackBar(context, 'لا يوجد اتصال انترنت');
      isLoading = false;
    } catch (e) {
      showSnackBar(context, e.toString());
      isLoading = false;
    }
  }

  deleteProfile({context}) async {
    var token = await getToken();
    try {
      isLoading = true;
      http.Response res =
          await http.delete(Uri.parse('$baseUrl/delete-account/'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token",
      });

      httpErrorHandler(
        response: res,
        context: context,
        onFailed: () {
          isLoading = false;
        },
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('access-token');
          prefs.remove('refresh-token');
          await prefs.setBool('auth-token', false);
          showSnackBar(context, 'تم حذف الحساب');
          isLoading = false;
          Restart.restartApp();
          isLoading = false;
        },
      );
    } on SocketException {
      showSnackBar(context, 'لا يوجد اتصال انترنت');
      isLoading = false;
    } catch (e) {
      showSnackBar(context, e.toString());
      isLoading = false;
    }
  }
}
