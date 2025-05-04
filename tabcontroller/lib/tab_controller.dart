import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/profile.dart';

class TabControllerScreen extends StatelessWidget {
  const TabControllerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, 
    child: Scaffold(
      appBar: AppBar(
        bottom: const TabBar(tabs: [
          Tab( icon: Icon(Icons.home),),
          Tab( icon: Icon(Icons.person),)
        ]),
        title: const Text('Tab Controller app'),
      ),
      body: const TabBarView(children: [
          HomeScreen(),
          ProfileScreen()
      ]),
    ));
  }
}