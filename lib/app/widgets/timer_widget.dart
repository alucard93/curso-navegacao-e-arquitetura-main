import 'dart:async';

import 'package:flutter/material.dart';

import 'package:fokus/app/utils/app_config.dart';

class TimerWidget extends StatefulWidget {
  final int initialMinutes;

  const TimerWidget({super.key, required this.initialMinutes});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  bool isPlaying = false;

  Timer? timer;
  Duration duration = Duration.zero;

  void startTimer() {
    setState(() {
      duration = Duration.zero;
    });

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (duration.inMinutes < widget.initialMinutes) {
          duration += Duration(seconds: 1);
        } else {
          isPlaying = false;
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromRGBO(20, 68, 128, 0.5),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xff144480), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Timer
          Text(
            "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}",
            style: TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 40),

          // Botões de controle
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isPlaying = !isPlaying;
                });
                if (isPlaying) {
                  startTimer();
                } else {
                  timer?.cancel();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isPlaying ? Colors.red : AppConfig.buttonColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: AppConfig.backgroundColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    isPlaying ? "Pausar" : "Iniciar",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppConfig.backgroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
