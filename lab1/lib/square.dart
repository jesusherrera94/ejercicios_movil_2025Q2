import 'package:flutter/material.dart';


class Square extends StatelessWidget {

  const Square({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.amber,
      ),
      child: Center( child: Text("Hello world!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),)
    );
  }
  
}