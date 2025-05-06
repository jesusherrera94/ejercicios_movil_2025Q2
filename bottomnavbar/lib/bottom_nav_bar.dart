import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/profile.dart';

class MyBottomNavigationBar extends StatefulWidget {
  
  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState(); 
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {

  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _screens = [
    {
      "title": 'Home',
      "screen": HomeScreen()
    },
    {
      "title": 'Profile',
      "screen": ProfileScreen()
    }
  ];

  void _selectedNewIndex (int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedIndex]["title"]),
        automaticallyImplyLeading: false, // esto para el futuro!
      ),
      body: _screens[_selectedIndex]['screen'],
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add),),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), // 0
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'), // 1
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blueAccent,
      onTap: _selectedNewIndex,
      ),
    );
  }

}
