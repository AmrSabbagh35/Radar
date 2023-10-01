import 'package:earthquake/features/tools/screens/risk_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'dart:io';

import 'package:earthquake/constants/consts.dart';
import 'package:earthquake/helpers/error_handling.dart';
import 'package:earthquake/helpers/utils.dart';
import 'package:http/http.dart' as http;

class ToolsProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  var pathToSaveAudio = 'audio.wav';
  FlutterSoundRecorder? recorder = FlutterSoundRecorder();
  FlutterSoundPlayer? player = FlutterSoundPlayer();
  bool isRecording = false;
  bool isPlaying = false;
  bool isInitialized = false;

  Future init() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('يرجى اعطاء صلاحيات');
    }

    // Get the application documents directory
    Directory? appDocumentsDirectory = await getApplicationDocumentsDirectory();

    // Construct the full file path
    pathToSaveAudio = '${appDocumentsDirectory.path}/audio.wav';

    recorder!.openRecorder();
    player!.openPlayer();
    isInitialized = true;
  }

  Future dis() async {
    if (!isInitialized) return;
    await recorder!.closeRecorder();
    await player!.closePlayer();
    recorder = null;
    player = null;
    isInitialized = false;
  }

  Future _startRecording() async {
    if (!isInitialized) return;

    try {
      await recorder!.startRecorder(
        toFile: pathToSaveAudio,
        codec: Codec.pcm16WAV,
      );
      isRecording = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Recording failed: $e');
    }
  }

  Future _stopRecording() async {
    if (!isInitialized) return;
    try {
      String? path = await recorder!.stopRecorder();
      isRecording = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Recording stop failed: $e');
    }
  }

  Future _startPlayback() async {
    if (!isInitialized) return;

    try {
      await player!.startPlayer(
        fromURI: pathToSaveAudio,
        codec: Codec.pcm16WAV,
      );
      isPlaying = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Playback failed: $e');
    }
  }

  Future _stopPlayback() async {
    if (!isInitialized) return;
    try {
      await player!.stopPlayer();
      isPlaying = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Playback stop failed: $e');
    }
  }

  void toggleRecording() async {
    if (recorder!.isStopped) {
      await _startRecording();
    } else {
      await _stopRecording();
    }
  }

  void togglePlayback() async {
    if (player!.isStopped) {
      await _startPlayback();
    } else {
      await _stopPlayback();
    }
  }

  Future<String?> smsEmergency({required String message}) async {
    try {
      String result =
          await sendSMS(message: message, recipients: ['0932179032']);
      debugPrint(result);
      return result;
    } catch (e) {
      debugPrint('Error sending emergency SMS: $e');
      return null;
    }
  }

  void sendAudio({context}) async {
    isLoading = true;
    var token = await getToken();

    try {
      final File audioFile = File(pathToSaveAudio);
      if (!await audioFile.exists()) {
        isLoading = false;
        showSnackBar(context, 'Audio file not found');
        return;
      }

      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/audio_to_txt/'));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'application/json; charset=utf-8';

      // Add the audio file to the request
      var audioStream = http.ByteStream(audioFile.openRead());
      var audioLength = await audioFile.length();
      var audioUri = Uri.file(audioFile.path);
      var audioMultipartFile = http.MultipartFile(
        'audio',
        audioStream,
        audioLength,
        filename: audioUri.pathSegments.last,
        contentType: MediaType('audio', 'wav'),
      );
      request.files.add(audioMultipartFile);
      var res = await request.send();
      var responseBodyBytes = await res.stream.toBytes();
      var responseBody = utf8.decode(responseBodyBytes);
      print('Raw response: $responseBody');

      httpErrorHandler(
        response: http.Response(responseBody, res.statusCode),
        context: context,
        onSuccess: () async {
          isLoading = false;
          var message = responseBody.toString();
          await smsEmergency(message: message);
          showSnackBar(context, 'تم ارسال الرسالة للطوارئ');
          Navigator.pop(context);
        },
        onFailed: () {
          isLoading = false;
          var message = responseBody.toString();
          showSnackBar(context, message);
        },
      );
    } on SocketException {
      isLoading = false;
      showSnackBar(context, 'لا يوجد اتصال انترنت');
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
      isLoading = false;
    }
  }

  void getRiskLevel({context, systolic, diastolic, heartrate}) async {
    isLoading = true;
    var token = await getToken();
    try {
      http.Response res = await http.post(Uri.parse('$baseUrl/risk_level/'),
          body: jsonEncode({
            "systolic_bp": systolic,
            "diastolic_bp": diastolic,
            "heart_rate": heartrate
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
            var level = jsonDecode(res.body)['message'];
            level == 'high risk'
                ? launchPhone('0932179032')
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RiskScreen()));
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
      debugPrint(e.toString());
      isLoading = false;
    }
  }

  void updateRiskLevel({context, systolic, diastolic, heartrate}) async {
    isLoading = true;
    var token = await getToken();
    try {
      http.Response res = await http.put(Uri.parse('$baseUrl/risk_level/'),
          body: jsonEncode({
            "systolic_bp": systolic,
            "diastolic_bp": diastolic,
            "heart_rate": heartrate
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
            var level = jsonDecode(res.body)['message'];
            level == 'high risk'
                ? launchPhone('0932179032')
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RiskScreen()));
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
      debugPrint(e.toString());
      isLoading = false;
    }
  }
}
