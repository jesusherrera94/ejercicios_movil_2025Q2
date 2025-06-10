import 'package:flutter/material.dart';

import '../adapters/local_storage.dart';
import '../adapters/dio_adapter.dart';
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
  String _email = '';
  String _password = '';
  String _error = '';

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
      setState(() {
        _error = '';
      });
      try {
        dynamic loginUser = await Auth.signInWithEmailAndPassword(_email, _password);
       String userUid = loginUser.user.uid;
        dynamic response = await _dioAdapter.getRequest(
        'https://subscriptions-be.vercel.app/api/users/$userUid',
      );
        User user = User.fromMap(response['user']);
        await _localStorage.setUserData('user', user.toMapString());
        _goToAppController(context);
      }
      catch(error) {
        print("Error ocurred trying to login: $error");
        setState(() {
          _error = 'Error trying to login, try again!';
        });
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
                      if (_error.isNotEmpty) ...[
                        SizedBox(height: 10,),
                        Text(_error, style: TextStyle(color: Colors.redAccent),)
                      ],

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
