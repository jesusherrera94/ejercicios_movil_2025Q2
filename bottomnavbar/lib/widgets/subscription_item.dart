import 'package:flutter/material.dart';
import '../models/subscription.dart';
import '../utils/time_utils.dart';

class SubscriptionItem extends StatelessWidget {
  final Subscription subscriptionElement;
  // prop drilling
  const SubscriptionItem({super.key, required this.subscriptionElement});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(subscriptionElement.icon),
        title: Row(
          children: [
            Text(subscriptionElement.platformName),
            SizedBox(width: 5),
            Text(
              "\$ ${subscriptionElement.charge}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                Text("Period: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(subscriptionElement.renovationCiclye.name),
              ],
            ),
            Row(
              children: [
                Text(
                  "Next renovation date: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(timestampToDatestring(subscriptionElement.renovationDate)),
              ],
            ),
          ],
        ),
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete, color: const Color.fromARGB(255, 205, 61, 61),)),
      ),
    );
  }
}
