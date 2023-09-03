import 'package:flutter/material.dart';
import 'package:heartforkhanhha/heart_beat_animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: HeartbeatAnimation(),
        ),
      ),
    );
  }
}
