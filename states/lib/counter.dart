import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class Counter extends StatefulWidget {
  const Counter({super.key});
 @override
 State<Counter> createState() => _CounterState(); 
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  late Timer _timer;

  @override
  void initState() {
    _startCountDown();
    super.initState();
  }

  void _startCountDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_counter <=0 ) {
        setState(() {
          _counter = 10;
        });
      } else {
        setState(() {
          _counter--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('$_counter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

}