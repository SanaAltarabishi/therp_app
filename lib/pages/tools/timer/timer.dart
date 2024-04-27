import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Stopwatch _stopwatch = Stopwatch();
  late Timer? _timer;
  String _currentTime = '00:00:00';
  String _formaterTime(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    String hours = twoDigits(duration.inHours.remainder(60));
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = _formaterTime(_stopwatch.elapsed);
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _resetTimer() {
    _stopwatch.reset();
    setState(() {
      _currentTime = '00:00:00';
    });
  }

  @override
  void initState() {
    _timer = null;
    super.initState();
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3dbcc),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 250,
                    height: 250,
                    child: Image.asset(
                      'images/toolsImages/sand-clock.png',
                      fit: BoxFit.cover,
                    )).animate().rotate(delay: .4.seconds, duration: .5.seconds),
                    //.fade(delay: .4.seconds, duration: .5.seconds),
                Text(
                  _currentTime,
                  style: const TextStyle(
                      color: Color(0xffcb8780),
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ).animate().fade(delay: .6.seconds, duration: .5.seconds),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _stopwatch.start();
                          _startTimer();
                        },
                        style: ElevatedButton.styleFrom(
                          // textStyle: TextStyle(color:Color(0xfff3dbcc),fontSize: 20,fontWeight: FontWeight.bold),
                          backgroundColor: const Color(0xffcb8780),
                          shadowColor: const Color(0xffcb8780),
                          foregroundColor:
                              const Color.fromARGB(255, 136, 24, 12),
                        ),
                        child: const Text(
                          "Start",
                          style: TextStyle(
                              color: Color(0xfff3dbcc),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ).animate().fade(delay: .6.seconds, duration: .5.seconds),
                      const SizedBox(
                        width: 25,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _stopwatch.stop();
                          _startTimer();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffcb8780),
                          shadowColor: const Color(0xffcb8780),
                          foregroundColor:
                              const Color.fromARGB(255, 136, 24, 12),
                        ),
                        child: const Text(
                          "Stop",
                          style: TextStyle(
                              color: Color(0xfff3dbcc),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ).animate().fade(delay: .8.seconds, duration: .5.seconds),
                      const SizedBox(
                        width: 25,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _stopwatch.stop();
                          _startTimer();
                          _resetTimer();
                        },
                        style: ElevatedButton.styleFrom(
                          // textStyle: TextStyle(color:Color(0xfff3dbcc),fontSize: 20,fontWeight: FontWeight.bold),
                          backgroundColor: const Color(0xffcb8780),
                          shadowColor: const Color(0xffcb8780),
                          foregroundColor:
                              const Color.fromARGB(255, 136, 24, 12),
                        ),
                        child: const Text(
                          "Restet",
                          style: TextStyle(
                              color: Color(0xfff3dbcc),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ).animate().fade(delay: 1.seconds, duration: .5.seconds),
                    ],
                  ),
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xffcb8780),
            ),
          ).animate().fade(delay: .2.seconds, duration: .3.seconds),
        ],
      ),
    );
  }
}
