// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:earthquake/common/build_text.dart';
import 'package:earthquake/constants/colors.dart';
import 'package:earthquake/constants/sizes.dart';
import 'package:earthquake/features/tools/services/tools_provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class VoiceRecordingScreen extends StatefulWidget {
  const VoiceRecordingScreen({Key? key}) : super(key: key);

  @override
  VoiceRecordingScreenState createState() => VoiceRecordingScreenState();
}

class VoiceRecordingScreenState extends State<VoiceRecordingScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _isRecording = false;
  bool _isPlaying = false;
  double _sliderValue = 0;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _isPlaying = false;
    _isRecording = false;
    context.read<ToolsProvider>().init();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation =
        Tween<double>(begin: 0, end: _elapsedSeconds.toDouble()).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    super.initState();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
        if (_isPlaying) {
          _sliderValue = _elapsedSeconds.toDouble();
        }
      });
    });
  }

  void pauseTimer() {
    _timer?.cancel();
  }

  void resetTimer() async {
    final recorder = context.read<ToolsProvider>().recorder;
    final player = context.read<ToolsProvider>().player;
    if (recorder!.isRecording) {
      await recorder.stopRecorder();
    }
    if (player!.isPlaying) {
      await player.stopPlayer();
    }

    context.read<ToolsProvider>().isRecording = false;
    setState(() {
      _isPlaying = false;
      _isRecording = false;
      _elapsedSeconds = 0;
      _sliderValue = 0;
    });

    if (_isRecording) {
      startTimer();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isRecording = context.watch<ToolsProvider>().isRecording;
    _isPlaying = context.watch<ToolsProvider>().isPlaying;
    final recorder = context.read<ToolsProvider>();

    if (_isRecording && _timer == null) {
      startTimer();
    } else if (!_isRecording && _timer != null) {
      pauseTimer();
    }

    IconData micIcon = _isRecording ? Icons.mic : Icons.mic_none;
    Color micColor = _isRecording ? Colors.red : Colors.grey;

    IconData playIcon = _isPlaying ? Icons.stop : Icons.play_arrow;
    Color playColor = const Color.fromARGB(255, 199, 65, 45);

    String formattedTime = formatTime(_elapsedSeconds);

    return Scaffold(
      appBar: AppBar(
        title: const Text('أداة إرسال رسالة طوارئ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            recordButton(recorder, micColor, micIcon),
            SizedBox(height: sh * 0.05),
            recordText(),
            SizedBox(height: sh * 0.05),
            recordDuration(formattedTime),
            SizedBox(height: sh * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: sw * 0.8,
                  child: ProgressBar(
                    progress: Duration(seconds: _sliderValue.toInt()),
                    total: Duration(seconds: _elapsedSeconds),
                    timeLabelType: TimeLabelType.totalTime,
                    thumbColor: playColor,
                    progressBarColor: primary,
                    baseBarColor: Colors.grey.withOpacity(0.2),
                    timeLabelLocation: TimeLabelLocation.below,
                    timeLabelTextStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    onSeek: (duration) {
                      if (_isPlaying) {
                        setState(() {
                          recorder.player!.seekToPlayer(duration);
                          _sliderValue = duration.inSeconds.toDouble();
                          _elapsedSeconds = duration.inSeconds;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    recorder.togglePlayback();
                    setState(() {
                      _sliderValue = _elapsedSeconds.toDouble();
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 50,
                    height: 50,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: playColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 6),
                          color: micColor.withOpacity(0.4),
                          blurRadius: _isPlaying ? 12 : 0,
                        ),
                      ],
                    ),
                    child: Icon(
                      playIcon,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: sh * 0.06),
            GestureDetector(
              onTap: () async {
                recorder.sendAudio(context: context);
              },
              child: Container(
                height: sh * 0.08,
                width: sw * 0.5,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 7),
                      color: Colors.grey.withOpacity(.2),
                      blurRadius: 12,
                    ),
                  ],
                  color: primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: context.watch<ToolsProvider>().isLoading
                      ? LoadingAnimationWidget.discreteCircle(
                          color: Colors.white, size: 20)
                      : CustomText(
                          text: 'ارسال',
                          size: sh * 0.03,
                          weight: FontWeight.bold,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
            SizedBox(
              height: sh * 0.03,
            ),
            TextButton(
              onPressed: resetTimer,
              child: Text(
                'إعادة التسجيل',
                style: TextStyle(
                  color: primary,
                  fontSize: sh * 0.03,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text recordDuration(String formattedTime) {
    return Text(
      'المدة: $formattedTime ثانية',
      style: const TextStyle(fontSize: 20),
    );
  }

  Text recordText() {
    return Text(
      _isRecording ? 'يتم التسجيل ...' : 'اضغط لبدء التسجيل',
      style: const TextStyle(fontSize: 20),
    );
  }

  GestureDetector recordButton(
      ToolsProvider recorder, Color micColor, IconData micIcon) {
    return GestureDetector(
      onTap: () {
        recorder.toggleRecording();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 300,
        height: 300,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: micColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 6),
              color: micColor.withOpacity(0.4),
              blurRadius: _isRecording ? 12 : 0,
            ),
          ],
        ),
        child: Icon(
          micIcon,
          size: 120,
          color: Colors.white,
        ),
      ),
    );
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }
}
