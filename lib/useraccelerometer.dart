import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class UserAcceler extends StatefulWidget {
  const UserAcceler({super.key});

  @override
  _UserAccelerState createState() => _UserAccelerState();
}

class _UserAccelerState extends State<UserAcceler> {
  UserAccelerometerEvent? _lastEvent;
  late StreamSubscription<UserAccelerometerEvent> _streamSubscription;

  @override
  void initState() {
    super.initState();
    // 註冊加速度感應器事件監聽
    _streamSubscription =
        userAccelerometerEvents.listen((UserAccelerometerEvent event) {
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
      title: 'UserAcceler Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('UserAcceler Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '加速度(使用者對裝置不包括重力)',
                style: TextStyle(fontSize: 24),
              ),
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
