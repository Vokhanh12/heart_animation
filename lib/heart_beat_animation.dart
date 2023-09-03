import 'dart:math';

import 'package:flutter/material.dart';

class HeartbeatAnimation extends StatefulWidget {
  @override
  _HeartbeatAnimationState createState() => _HeartbeatAnimationState();
}

class _HeartbeatAnimationState extends State<HeartbeatAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHeartBeat = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _isHeartBeat = false;
          });
          _controller.reverse();
        }
      });
  }

  void _startHeartbeat() {
    setState(() {
      _isHeartBeat = true;
    });
    _controller.forward();
  }

  double randomX() {
    final random = Random();
    return random.nextDouble() * 1000 -
        200; // Sử dụng số khác nếu bạn muốn nổi bọt ở vị trí khác
  }

  double randomY() {
    final random = Random();
    return random.nextDouble() * 1000 -
        200; // Sử dụng số khác nếu bạn muốn nổi bọt ở vị trí khác
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeigth,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          AnimatedPositioned(
            duration: Duration(milliseconds: 700),
            bottom: _isHeartBeat ? 200 : 0,
            child: Opacity(
              opacity: _isHeartBeat ? 1 : 0,
              child: Padding(
                padding: EdgeInsets.only(bottom: 350),
                child: Text(
                  'Dễ thương',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          if (_isHeartBeat)
            for (var i = 0; i < 20; i++)
              Positioned(
                left: randomX(),
                top: randomY(),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _controller.value,
                      child: Image.asset(
                        './lib/assets/image/Heart.png',
                        width: 90,
                        height: 90,
                      ),
                    );
                  },
                ),
              ),
          GestureDetector(
            onTap: () {
              _startHeartbeat();
            },
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _isHeartBeat ? 1.2 : 1.0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          child: Image.asset(
                            './lib/assets/image/Heart.png',
                            width: screenWidth / 2,
                            height:
                                screenHeigth / 2, // Đã sửa thành screenHeight
                          ),
                        ),
                        Positioned(
                          child: Text(
                            'Click me',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
