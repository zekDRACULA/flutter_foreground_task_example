import 'dart:async';
import 'package:flutter/material.dart';

class TimerExample extends StatefulWidget {
  @override
  _TimerExampleState createState() => _TimerExampleState();
}

class _TimerExampleState extends State<TimerExample> {
  int _seconds = 0;
  Timer? _timer;

  void _startTimer() {
    if (_timer != null && _timer!.isActive) return;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _seconds = 0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Clean up when widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Timer Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Time: $_seconds seconds', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _startTimer, child: Text('Start')),
            ElevatedButton(onPressed: _stopTimer, child: Text('Stop')),
            ElevatedButton(onPressed: _resetTimer, child: Text('Reset')),
          ],
        ),
      ),
    );
  }
}
