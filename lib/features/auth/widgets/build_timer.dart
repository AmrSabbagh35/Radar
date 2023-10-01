// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:earthquake/constants/sizes.dart';
import 'package:flutter/material.dart';

class VerifyTimer extends StatefulWidget {
  const VerifyTimer({Key? key}) : super(key: key);

  @override
  _VerifyTimerState createState() => _VerifyTimerState();
}

class _VerifyTimerState extends State<VerifyTimer> {
  late Timer _timer;
  Duration _duration = const Duration(minutes: 15);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTimer(Timer timer) {
    setState(() {
      if (_duration.inSeconds > 0) {
        _duration -= const Duration(seconds: 1);
      } else {
        timer.cancel();
      }
    });
  }

  String _getDurationString(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final durationString = _getDurationString(_duration);
    final minutes = durationString.substring(3, 5);
    final seconds = durationString.substring(6, 8);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        '$minutes:$seconds',
        style: TextStyle(color: Colors.red[900], fontSize: sh * 0.025),
      ),
    );
  }
}
