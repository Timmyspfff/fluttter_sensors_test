import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Squat extends StatefulWidget {
  const Squat({super.key});

  @override
  _SquatState createState() => _SquatState();
}

class _SquatState extends State<Squat> {
  AccelerometerEvent? _lastEvent;
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  var squatcount = 0;
  var squatflag = 1;
  @override
  void initState() {
    super.initState();
    // 註冊加速度感應器事件監聽
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) async {
      if (event.y > 2.5 && squatflag == 1) {
        squatcount++;
        squatflag = 0;
      }
      if (event.y < 2.5 && squatflag == 0) {
        squatflag = 1;
      }

      setState(() {
        _lastEvent = event;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    // 取消事件監聽
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squat Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Squat Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '深蹲',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '深蹲次數：${squatcount.toString()}',
                style: const TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                  onPressed: () {
                    squatcount = 0;
                  },
                  child: const Text("深蹲重置")),
              const SizedBox(height: 16),
              Text(
                'X 軸加速度：${_lastEvent?.x.toStringAsFixed(2) ?? 0}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Y 軸加速度：${_lastEvent?.y.toStringAsFixed(2) ?? 0}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Z 軸加速度：${_lastEvent?.z.toStringAsFixed(2) ?? 0}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
