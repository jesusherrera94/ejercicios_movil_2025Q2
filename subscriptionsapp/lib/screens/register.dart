import 'dart:convert' as convert;
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


  final _formKey = GlobalKey<FormState>();
  DioAdapter _dioAdapter = DioAdapter();
  LocalStorage _localStorage = LocalStorage();
  bool _isLoading = false;


  User _user = User(
    username: '',
    fullname: '',
    email: '',
    password: '',
    principalInterest: '');

  void _displaySnackbar(BuildContext context, String message) {
    SnackBar snackBar = SnackBar(content: Text(message),
      action: SnackBarAction(label: 'Undo | deshacer', onPressed: () {
        print('Hola snackbar');
      }),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
   Navigator.pushNamed(context, 'app-controller');
  }

  void onSubmit() async {
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        _user.profilePicture = 'https://example.com/profile2.jpg';

        dynamic response = await _dioAdapter.postRequest('https://subscriptions-be.vercel.app/api/users', _user.toMap());
        setState(() {
          _isLoading = false;
        });
        User newUser = User.fromMap(response["user"]);
        await _localStorage.setUserData('user', newUser.toMapString());
        await _localStorage.setLoginStatus(true);

        // Testing the localStorage data
        String userString = await _localStorage.getUserData('user');
        dynamic userMap = convert.jsonDecode(userString);
        print('====================> $userMap');
        // _displaySnackbar(context, 'User registered successfully: ${userMap['username']}');

      } catch(e) {
        print('An error ocurred trying to create user: $e');
        _displaySnackbar(context, 'An error has ocurred trying to create user!');
        setState(() {
        _isLoading = false;
      });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: 
            Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the username';
                    }
                    return null;
                  },
                  onSaved: (value) => _user.username = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Full name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Full name';
                    }
                    return null;
                  },
                  onSaved: (value) => _user.fullname = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Email';
                    }
                    if(!value.contains("@")){
                      return 'Please enter a valid Email';
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
                      return 'Please enter the Password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  onSaved: (value) => _user.password = value!,
                ),
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
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    
                    onPressed: () {
                      if (!_isLoading){
                        onSubmit();
                      }
                  }, child: _isLoading ? CircularProgressIndicator() : Text("Register"),
                  )

              ],
            )
            ),
        
        ),
      )
    );
  }
}
