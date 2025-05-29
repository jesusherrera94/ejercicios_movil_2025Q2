import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import '../adapters/local_storage.dart';
import '../adapters/dio_adapter.dart';
import '../adapters/http_adapter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  bool _hasLoaded = false;
  LocalStorage _localStorage = LocalStorage();
  DioAdapter _dioAdapter = DioAdapter();
  HttpAdapter _httpAdapter = HttpAdapter();


  @override
  void initState() {
    _validateLogin(context);
    super.initState();
  }

  void _validateLogin(BuildContext context) async {
    try {
        bool isAuthenticated = await _localStorage.getLoginStatus();
        dynamic response = await _dioAdapter.getRequest('https://official-joke-api.appspot.com/random_ten');
        dynamic responseHttp = await _httpAdapter.getRequest('official-joke-api.appspot.com', '/random_ten');
        List<dynamic> responseMap = convert.jsonDecode(responseHttp);
        String dioResponseStr = convert.jsonEncode(response);
        print('=======>: ${response[0]["setup"]}');
        print('========>: $responseHttp');
        print('==========>: ${responseMap[0]}');
        print('${response.runtimeType} : ${responseHttp.runtimeType} : ${responseMap.runtimeType} : ${dioResponseStr.runtimeType}');
        print('=========> $dioResponseStr');
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