import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class Counter extends StatefulWidget {

  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();

}


class _CounterState extends State<Counter> with WidgetsBindingObserver {

  int _counter = 0;

  late Timer _timer;

  @override
  void initState() {
    _startCountDown();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }


  void _startCountDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if(_counter <= 0) {
        _counter = 10; 
      } else {
        _counter--;
      }
      setState(() {});
      print('=====> $_counter');
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state) {
      case AppLifecycleState.paused:
        print('User exits app!');
        _timer.cancel();
        break;
      case AppLifecycleState.resumed:
        print('User returned to app');
        _startCountDown();
        break;
      default:
        print('No State detected');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
     WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('$_counter', style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold),),
    );
  }

}
