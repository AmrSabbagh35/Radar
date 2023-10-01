import 'dart:convert';
import 'package:earthquake/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';

void httpErrorHandler({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
  required VoidCallback onFailed,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 201:
      onSuccess();
      break;
    case 204:
      onSuccess();
      break;
    case 205:
      onSuccess();
      break;
    case 400:
      debugPrint('400');
      debugPrint(response.body);
      showSnackBar(context, jsonDecode(response.body)['message']);
      onFailed();
      break;
    case 500:
      debugPrint('500');
      debugPrint(response.body);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Scaffold(
                    body:
                        SingleChildScrollView(child: Html(data: response.body)),
                  )));
      showSnackBar(context, jsonDecode(response.body)['message']);
      onFailed();
      break;
    default:
      showSnackBar(context, jsonDecode(response.body));
      debugPrint(response.statusCode.toString());
      onFailed();
      break;
  }
}
