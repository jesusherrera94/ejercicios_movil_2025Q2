import 'package:flutter/material.dart';
import '../widgets/wave_button.dart';
class AddEndry extends StatefulWidget {
  const AddEndry({super.key});

  @override
  State<AddEndry> createState() => _AddEndryState();
}

class _AddEndryState extends State<AddEndry> {

  void _onCreateSubscription() {
    print('subscription created!!!!!!!!!!!!!!!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Add Subscription"),),
      body: Center(
      child: Column(
        children: [
          Text('Add entry here!'),
          SizedBox(height: 30,),
          WaveButton(onPressed: _onCreateSubscription, child: const Text('Add subscription'))
        ],
      ),
    ),
    );
  }
}