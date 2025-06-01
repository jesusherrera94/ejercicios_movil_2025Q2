import 'package:flutter/material.dart';

import '../models/subscription.dart';
import '../widgets/wave_button.dart';


class AddEndry extends StatefulWidget {
  const AddEndry({super.key});

  @override
  State<AddEndry> createState() => _AddEndryState();
}

class _AddEndryState extends State<AddEndry> {
  final _formKey = GlobalKey<FormState>();

  Subscription _newSubscription = Subscription(
    platformName: '',
    renovationDate: 0,
    renovationCycle: Period.NONE,
    charge: 0.0,);

    void _onCreateSubscription() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        // Aquí puedes agregar la lógica para guardar la nueva suscripción
        print('Nueva suscripción creada: ${_newSubscription.toMap()}');
        // Luego de guardar, puedes navegar a otra pantalla o mostrar un mensaje de éxito
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Subscription Entry'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Card(  
          child: Form(
            key: _formKey,
            child: Padding(padding:EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Platform'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the platform';
                    }
                    return null;
                  },
                  onSaved: (value) => _newSubscription.platformName = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Renovation Date'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the renovation Date';
                    }
                    return null;
                  },
                  onSaved: (value) => _newSubscription.renovationDate = int.parse(value!),
                ),

                // change to DropdownButtonFormField
                DropdownButtonFormField<Period>(
                  decoration: const InputDecoration(labelText: 'Renovation Cycle'),
                  items: Period.values.map((Period period) {
                    return DropdownMenuItem<Period>(
                      value: period,
                      child: Text(period.toString().split('.').last),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _newSubscription.renovationCycle = value;
                    }
                  },
                  validator: (value) {
                    if (value == null || value == Period.NONE) {
                      return 'Please select a renovation cycle';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Charge'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the charge';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (value) => _newSubscription.charge = double.parse(value!),
                ),
                  const SizedBox(height: 30,),
                  WaveButton(
                    child: const Text("Add Subscription"),
                    onPressed: () => _onCreateSubscription(),
                  ),
              ],
            ),
            ),
        ),
        ),
        )
      ),
    ));
  }
}