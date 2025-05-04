import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/profile.dart';


class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});
  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {

  int _selectedIndex = 0;

  static const List<Widget> _screens = [
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
        title: Text('My app title!'),
        leading: Builder(builder: (context) {
          return IconButton(onPressed: () {
            Scaffold.of(context).openDrawer();
          }, icon: const Icon(Icons.menu));
        }),
        ),
      body: _screens[_selectedIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text('Drawer Header!')),
              ListTile(
                title: const Text('Home'),
                selected: _selectedIndex == 0,
                onTap: () {
                  _onTapMenuItem(0);
                  // closes the drawer!
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Profile'),
                selected: _selectedIndex == 1,
                onTap: () {
                  _onTapMenuItem(1);
                  // closes the drawer!
                  Navigator.pop(context);
                },
              )
          ],
        ),
      ),
    );

  }
}