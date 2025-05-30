import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../adapters/dio_adapter.dart';
import '../adapters/local_storage.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  // form key
  final _formKey = GlobalKey<FormState>();
  DioAdapter _dioAdapter = DioAdapter();
  LocalStorage _localStorage = LocalStorage();

  // User data
  final _user = User(
    username: '',
    fullname: '',
    email: '',
    password: '',
    principalInterest: '',
  );

  void _displaySnackbar(BuildContext context, String message) {
    SnackBar snackBar = SnackBar(content: Text(message),
      action: SnackBarAction(label: 'Undo | deshacer', onPressed: () {
        print('Hola snackbar');
      }),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pushNamed(context, 'app-controller');
  }

  void _onSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        _user.profilePicture = "https://example.com/profile2.jpg";
        dynamic response = await _dioAdapter.postRequest('https://subscriptions-be.vercel.app/api/users', _user.toMap());
        User newUser = User.fromMap(response['user']);
        _localStorage.setUserData('user', newUser.toMapString());
        _localStorage.setLoginStatus(true);
        // testing the local storage
        String userStr = await _localStorage.getUserData('user');
        dynamic userMap = jsonDecode(userStr);
        _displaySnackbar(context, 'User registered successfully: ${userMap['username']}');
      } catch (e) {
        print('An error has occurred!: $e');
        _displaySnackbar(context, 'An error has occurred trying to register the user!');
      }    
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey, // Form key
              child: Column(
                children: [
                  // TextFields
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                    onSaved: (value) => _user.username = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                    onSaved: (value) => _user.fullname = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) => _user.email = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    onSaved: (value) => _user.password = value!,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Your interest'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your interest';
                      }
                      return null;
                    },
                    onSaved: (value) => _user.principalInterest = value!,
                  ),

                  // Submit button
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: (){
                      _onSubmit(context);
                      }, // Callback function
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }



}