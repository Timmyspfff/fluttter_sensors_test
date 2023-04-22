import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Leglift extends StatefulWidget {
  const Leglift({super.key});

  @override
  _LegliftState createState() => _LegliftState();
}

class _LegliftState extends State<Leglift> {
  AccelerometerEvent? _lastEvent;
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  var legliftcount = 0;
  var legliftflag = 1;
  @override
  void initState() {
    super.initState();
    // 註冊加速度感應器事件監聽
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) async {
      if (event.z > 7 && legliftflag == 1) {
        legliftcount++;
        legliftflag = 0;
      }
      if (event.z < 7 && legliftflag == 0) {
        legliftflag = 1;
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
      title: 'Leglift Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Leglift Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '抬腿',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '抬腿次數：${legliftcount.toString()}',
                style: const TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                  onPressed: () {
                    legliftcount = 0;
                  },
                  child: const Text("抬腿重置")),
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
