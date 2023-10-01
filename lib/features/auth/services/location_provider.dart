import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class LocationProvider extends ChangeNotifier {
  // ignore: prefer_typing_uninitialized_variables
  var isDeviceConnected;
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  String locationmessage = 'الموقع الحالي : غير محدد بعد';
  String lp = 'الموقع الأخير : غير محدد بعد';
  String lat = '';
  String long = '';
  bool sent = false;
  Future<Position> getPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getCurrentLocation() async {
    try {
      isLoading = true;
      var status = await Geolocator.checkPermission();
      if (status == LocationPermission.denied) {
        var requeststatus = await Geolocator.requestPermission();
        if (requeststatus == LocationPermission.always ||
            requeststatus == LocationPermission.whileInUse) {
          var position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          locationmessage = '$position';
          long = position.longitude.toString();
          lat = position.latitude.toString();
          sent = true;
          isLoading = false;
          Fluttertoast.showToast(msg: 'تم ارسال الموقع بنجاح !');
        }
      } else {
        var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        var lastposition = await Geolocator.getLastKnownPosition();
        locationmessage = '$position';
        lp = '$lastposition';
        sent = true;
        long = position.longitude.toString();
        lat = position.latitude.toString();

        isLoading = false;
        Fluttertoast.showToast(msg: 'تم تحديد الموقع بنجاح !');
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  getlocation() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if (isDeviceConnected) {
      sent
          ? Fluttertoast.showToast(msg: 'تم تحديد الموقع مسبقا')
          : getCurrentLocation();
    } else {
      locationmessage = 'لا يوجد اتصال بالانترنت';
      lp = 'لا يوجد اتصال بالانترنت';
      notifyListeners();
      Fluttertoast.showToast(msg: 'يرجى الاتصال بالانترنت');
    }
  }
}
