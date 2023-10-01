// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:earthquake/constants/consts.dart';
import 'package:earthquake/features/auth/screens/confirm_pass_screen.dart';
import 'package:earthquake/features/auth/screens/login_screen.dart';
import 'package:earthquake/helpers/error_handling.dart';
import 'package:earthquake/helpers/utils.dart';
import 'package:earthquake/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  signIn({context, username, password, fcmtoken}) async {
    isLoading = true;
    try {
      http.Response res = await http.post(Uri.parse('$baseUrl/login/'),
          body: jsonEncode({
            "username": "$username",
            "password": "$password",
            "registration_token": fcmtoken
          }),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString(
                'refresh-token', jsonDecode(res.body)['refresh']);
            await prefs.setString(
                'access-token', jsonDecode(res.body)['access']);
            await prefs.setBool('auth-token', true);
            debugPrint(prefs.getString('access-token'));
            isLoading = false;
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MainScreen()));
          },
          onFailed: () {
            isLoading = false;
            showSnackBar(context, jsonDecode(res.body)['message']);
            print(jsonDecode(res.body)['message']);
          });
    } on SocketException {
      isLoading = false;
      showSnackBar(context, 'لا يوجد اتصال انترنت');
    } catch (e) {
      showSnackBar(context, e.toString());
      isLoading = false;
      print(e.toString());
    }
  }

  void signupUser({
    required BuildContext context,
    required String fullName,
    required String username,
    required int age,
    required String phoneNumber,
    required int familyMembersNumber,
    required String password,
    required String email,
    required String address,
    required String illness,
    required double long,
    required double lat,
    required File? profilePhoto,
  }) async {
    final url = Uri.parse('$baseUrl/register/');
    final request = http.MultipartRequest('POST', url);

    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields.addAll({
      'full_name': fullName,
      'username': username,
      'age': age.toString(),
      'phone': phoneNumber.toString(),
      'email': email,
      'password': password,
      'family_members': familyMembersNumber.toString(),
      'illnesses': illness,
      'address': address,
      'latitude': lat.toString(),
      'longitude': long.toString(),
    });

    final file = await http.MultipartFile.fromPath('image', profilePhoto!.path);
    request.files.add(file);

    try {
      isLoading = true;
      final res = await request.send();
      final response = await res.stream.bytesToString();
      httpErrorHandler(
        response: http.Response(response, res.statusCode),
        context: context,
        onFailed: () {
          isLoading = false;
        },
        onSuccess: () async {
          isLoading = false;

          showSnackBar(context, 'تم إنشاء الحساب بنجاح');
          await Fluttertoast.showToast(msg: 'سجل الدخول بمعلومات الحساب');
          Navigator.pop(context);
        },
      );
    } on SocketException {
      isLoading = false;
      showSnackBar(context, 'لا يوجد اتصال انترنت');
    } catch (e) {
      isLoading = false;
      showSnackBar(context, e.toString());
    }
  }

  signOut({context}) async {
    isLoading = true;
    var token = await getToken();
    var refreshToken = await getRefreshToken();
    try {
      http.Response res = await http.post(Uri.parse('$baseUrl/logout/'),
          body: jsonEncode({'token': refreshToken}),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          });
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('access-token');
            prefs.remove('refresh-token');
            await prefs.setBool('auth-token', false);
            isLoading = false;
            Restart.restartApp();
          },
          onFailed: () {
            isLoading = false;
            showSnackBar(context, res.body);
          });
    } on SocketException {
      isLoading = false;
      showSnackBar(context, 'لا يوجد اتصال انترنت');
    } catch (e) {
      showSnackBar(context, e.toString());
      isLoading = false;
    }
  }

  forgotPass({context, email}) async {
    isLoading = true;
    try {
      http.Response res = await http.post(Uri.parse('$baseUrl/forget_pass/'),
          body: jsonEncode({"email": "$email"}),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            isLoading = false;
            showSnackBar(context, 'تم ارسال الرمز ! تأكد في بريدك الإلكتروني');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PinCodeScreen(email: email)));
          },
          onFailed: () {
            isLoading = false;
            showSnackBar(context, jsonDecode(res.body)['message']);
          });
    } on SocketException {
      isLoading = false;
      showSnackBar(context, 'لا يوجد اتصال انترنت');
    } catch (e) {
      showSnackBar(context, e.toString());
      isLoading = false;
    }
  }

  confirmPass({context, email, code, newpassword}) async {
    isLoading = true;
    try {
      http.Response res = await http.post(Uri.parse('$baseUrl/confirm_pass/'),
          body: jsonEncode(
              {"email": email, "code": code, "new_password": newpassword}),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            isLoading = false;
            showSnackBar(context, 'تم تغيير كلمة السر, سجل بمعلوماتك الجديدة');
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false,
            );
          },
          onFailed: () {
            isLoading = false;
            showSnackBar(context, jsonDecode(res.body)['message']);
          });
    } on SocketException {
      isLoading = false;
      showSnackBar(context, 'لا يوجد اتصال انترنت');
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
      isLoading = false;
    }
  }

  resetPass({context, email, oldpass, newpassword}) async {
    isLoading = true;
    var token = await getToken();
    try {
      http.Response res = await http.post(Uri.parse('$baseUrl/password_reset/'),
          body: jsonEncode({
            "email": email,
            "old_password": oldpass,
            "new_password": newpassword
          }),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          });
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            isLoading = false;
            showSnackBar(context, 'تم تغيير كلمة السر');
            Navigator.pop(context);
          },
          onFailed: () {
            isLoading = false;
            showSnackBar(context, jsonDecode(res.body)['message']);
          });
    } on SocketException {
      isLoading = false;
      showSnackBar(context, 'لا يوجد اتصال انترنت');
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
      isLoading = false;
    }
  }
}
