import 'package:flutter/material.dart';
import '../adapters/local_storage.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  bool _hasLoaded = false;
  LocalStorage _localStorage = LocalStorage();


  @override
  void initState() {
    _validateLogin(context);
    super.initState();
  }

  void _validateLogin(BuildContext context) async {
    try {
        bool isAuthenticated = await _localStorage.getLoginStatus();
        setState(() {
        _hasLoaded = true;
      });

      if(isAuthenticated) {
        Navigator.pushNamed(context, 'app-controller');
      }
    } catch(e) {
      print('Ocurrio un error! $e');
    }
    // await Future.delayed(Duration(seconds: 10));
    

  }


  void _goToAppController( BuildContext context) {
    _localStorage.setLoginStatus(true); // simulando que el usuario hizo login!
    Navigator.pushNamed(context, 'app-controller');
  }

  void _goToRegister(BuildContext context) {
    Navigator.pushNamed(context, 'register');
  }

  @override
  Widget build(BuildContext context) {

    if(!_hasLoaded) {
      return Scaffold(
        body: Center(
          child: Container(
            child: Text('Loading.......'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar( title: Text('Login'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login'),
            ElevatedButton(onPressed: () {
              _goToAppController(context);
            }, child: Text('Login')),
            GestureDetector(
              onTap: () {
                _goToRegister(context);
              },
              child: Container(
                margin: EdgeInsets.all(20),
                child: Text('Register', style: TextStyle(decoration: TextDecoration.underline),),
              ),
            )
          ],
        ),
      ),
    );
  }
}