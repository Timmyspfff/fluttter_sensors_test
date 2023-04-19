import 'package:flutter/material.dart';
import 'package:test/accelerometer.dart';
import 'package:test/gyroscope.dart';
import 'package:test/useraccelerometer.dart';

void main() {
  runApp(const MaterialApp(home: SensorDemo()));
}

class SensorDemo extends StatelessWidget {
  const SensorDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensors Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sensors Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BorderButton(
                text: 'Accelerometer',
                onPressed: () {
                  print('Accelerometer pressed');
                  // Navigator.pushNamed(context, '/accelerometer');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Accelerometer()));
                },
              ),
              const SizedBox(height: 16),
              BorderButton(
                text: 'UserAcceler',
                onPressed: () {
                  print('UserAcceler pressed');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserAcceler()));
                },
              ),
              const SizedBox(height: 16),
              BorderButton(
                text: 'GyroScope',
                onPressed: () {
                  print('GyroScope pressed');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GyroScope()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BorderButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BorderButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Colors.blue),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
