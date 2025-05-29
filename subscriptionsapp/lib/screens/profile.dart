import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 1,
      crossAxisSpacing: 5,
      mainAxisSpacing: 10,
      children: [
          Container(
            color: Colors.amber,
            child: Center( child: Text("Hola mundo!1"),),
          ),
          Container(
            color: Colors.amber,
            child: Center( child: Text("Hola mundo!2"),),
          ),
          Container(
            color: Colors.amber,
            child: Center( child: Text("Hola mundo!3"),),
          ),
          Container(
            color: Colors.amber,
            child: Center( child: Text("Hola mundo!4"),),
          ),
          Container(
            color: Colors.amber,
            child: Center( child: Text("Hola mundo!5"),),
          ),
          Container(
            color: Colors.amber,
            child: Center( child: Text("Hola mundo!6"),),
          ),
          Container(
            color: Colors.amber,
            child: Center( child: Text("Hola mundo!7"),),
          ),
          Container(
            color: Colors.amber,
            child: Center( child: Text("Hola mundo!8"),),
          ),
          Icon(Icons.person)
      ],
    );
  }
}
