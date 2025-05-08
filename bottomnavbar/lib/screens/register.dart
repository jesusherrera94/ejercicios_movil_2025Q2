import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  void _displaySnackbar(BuildContext context) {
    SnackBar snackBar = SnackBar(content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround, 
      children: [Icon(Icons.check, color: Colors.lightGreen,), Text('Todo bien!')],),
      action: SnackBarAction(label: 'Undo | deshacer', onPressed: () {
        print('Hola snackbar');
      }),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Resgiter'),
            GestureDetector(
              onTap: () {
                _displaySnackbar(context);
              },
              child: Container(
                margin: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                ),
                child: Text('Display Snackbar!'),
              ),
            ),
            IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.backspace))
          ],
        ),
      ),
    );
  }
}