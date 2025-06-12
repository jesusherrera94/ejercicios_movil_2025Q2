import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';

import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/add_entry.dart';
import 'bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    Permission.notification.request()
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: 'init',
      routes: {
        "init": (context) => Login(),
        "app-controller": (context) => MyBottomNavigationBar(),
        "register": (context) => Register(),
        "add-entry": (context) => AddEndry()
      },
    );
  }
}
