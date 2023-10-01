import 'dart:convert';
import 'dart:io';

import 'package:earthquake/constants/consts.dart';
import 'package:earthquake/helpers/error_handling.dart';
import 'package:earthquake/helpers/utils.dart';
import 'package:earthquake/models/latest_earthquake.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  List<LatestEarthquake> earthquakesList = [];

  getEarthQuakes({context, days}) async {
    try {
      isLoading = true;
      http.Response res = await http.post(Uri.parse('$baseUrl/earthquakes/'),
          body: jsonEncode({'days': days}),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandler(
        response: res,
        context: context,
        onFailed: () {
          isLoading = false;
        },
        onSuccess: () async {
          earthquakesList.clear();
          Map<String, dynamic> responseJson = json.decode(res.body);
          List<dynamic> earthquakesJson = responseJson['latest earthquakes'];
          for (Map<String, dynamic> item in earthquakesJson) {
            earthquakesList.add(LatestEarthquake.fromJson(item));
          }
          days == 1
              ? null
              : earthquakesList = earthquakesList.reversed.toList();
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
