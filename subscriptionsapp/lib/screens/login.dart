import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import '../adapters/local_storage.dart';
import '../adapters/dio_adapter.dart';
import '../adapters/http_adapter.dart';
import '../models/user.dart';
import '../widgets/wave_button.dart';
import '../adapters/auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool _hasLoaded = false;
  bool _isLoading = false;
  LocalStorage _localStorage = LocalStorage();
  DioAdapter _dioAdapter = DioAdapter();
  HttpAdapter _httpAdapter = HttpAdapter();
  String _email = '';
  String _password = '';
  User _user = User(
    username: '',
    fullname: '',
    email: '',
    password: '',
    principalInterest: '',
  );

  @override
  void initState() {
    _validateLogin(context);
    super.initState();
  }

  void _validateLogin(BuildContext context) async {
    try {
      bool isAuthenticated = await _localStorage.getLoginStatus();
      dynamic response = await _dioAdapter.getRequest(
        'https://official-joke-api.appspot.com/random_ten',
      );
      dynamic responseHttp = await _httpAdapter.getRequest(
        'official-joke-api.appspot.com',
        '/random_ten',
      );
      List<dynamic> responseMap = convert.jsonDecode(responseHttp);
      String dioResponseStr = convert.jsonEncode(response);
      print('=======>: ${response[0]["setup"]}');
      print('========>: $responseHttp');
      print('==========>: ${responseMap[0]}');
      print(
        '${response.runtimeType} : ${responseHttp.runtimeType} : ${responseMap.runtimeType} : ${dioResponseStr.runtimeType}',
      );
      print('=========> $dioResponseStr');
      setState(() {
        _hasLoaded = true;
      });

      if (isAuthenticated) {
        Navigator.pushNamed(context, 'app-controller');
      }
    } catch (e) {
      print('Ocurrio un error! $e');
    }
    // await Future.delayed(Duration(seconds: 10));
  }

  void _doLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      try {
        dynamic _loginUser = await Auth.signInWithEmailAndPassword(_email, _password);
       String userUid = _loginUser.user.uid;
      //   dynamic response = await _dioAdapter.getRequest(
      //   'https://subscriptions-be.vercel.app/api/users/$userUid',
      // );
        print('Email: $userUid');
      }
      catch(error) {
        print("Error ocurred trying to login: $error");
      }
    }
  }

  void _goToAppController(BuildContext context) {
    _localStorage.setLoginStatus(true); // simulando que el usuario hizo login!
    Navigator.pushNamed(context, 'app-controller');
  }

  void _goToRegister(BuildContext context) {
    Navigator.pushNamed(context, 'register');
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasLoaded) {
      return Scaffold(
        body: Center(child: Container(child: Text('Loading.......'))),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Card(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      Text(
                        "Enter your credentials",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20,),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blueAccent,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 35,
                          ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Email';
                          }
                          if (!value.contains("@")) {
                            return 'Please enter a valid Email';
                          }
                          return null;
                        },
                        onSaved: (value) => _email = value!,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        onSaved: (value) => _password = value!,
                      ),

                      const SizedBox(height: 30),
                      WaveButton(
                        onPressed: () {
                          if (!_isLoading) {
                            _doLogin();
                          }
                        },
                        child:
                            _isLoading
                                ? CircularProgressIndicator()
                                : Text("Login"),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          _goToRegister(context);
                        },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
