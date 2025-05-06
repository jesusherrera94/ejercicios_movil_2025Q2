import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/profile.dart';


class MenuDrawer extends StatefulWidget {

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
  
}

class _MenuDrawerState extends State<MenuDrawer> {

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ProfileScreen()
  ];

  void _onTapMenuItem(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My menu drawer!'),
        leading: Builder(builder: (context) {
          return IconButton(onPressed: () {
            Scaffold.of(context).openDrawer(); // abrir el menu
          }, icon: Icon(Icons.menu));
        }),
      ),
      body: _screens[_selectedIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // removiendo padding
          children: [
            DrawerHeader(child: Text('Drawer Header!'),
            decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            ListTile(
              title: Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onTapMenuItem(0);
                Navigator.pop(context); // cerrar el menu drawer
              },
            ),
            ListTile(
              title: Text('Profile'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onTapMenuItem(1);
                Navigator.pop(context); // cerrar el menu drawer
              },
            )
          ],
        ),
      ),
    );
  }
  
}
