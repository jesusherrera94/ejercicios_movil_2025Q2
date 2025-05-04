import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/profile.dart';

class MyBottomNavigationBar extends StatefulWidget {

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBar();

}


class _MyBottomNavigationBar extends State<MyBottomNavigationBar> {

  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _screens = [
     {
      "title": 'Home',
      "screen": HomeScreen(),
    },
    {
      "title": 'Profile',
      "screen": ProfileScreen(),
    }
  ];



  void _selectNewIndex(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  // TODO: implement conditional action button!

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedIndex]["title"]),
        automaticallyImplyLeading: false,
      ),
      body: _screens[_selectedIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
      ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _selectNewIndex,
      ),
    );
  }

}