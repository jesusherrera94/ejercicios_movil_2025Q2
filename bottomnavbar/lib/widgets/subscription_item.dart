import 'package:flutter/material.dart';
import '../models/subcription.dart';

class SubscriptionItem extends StatelessWidget {

  final Subscription subscriptionElement;
  // prop drilling
  const SubscriptionItem({super.key, required this.subscriptionElement});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(subscriptionElement.id),
            Text(subscriptionElement.platformName)
          ],
        ),
        Column(
          children: [
            Text(subscriptionElement.renovationCiclye.toString()),
            Text(subscriptionElement.renovationDate.toString())
          ],
        ),
        Column(
          children: [
            Text(subscriptionElement.userId),
            Text(subscriptionElement.charge.toString())
          ],
        )
      ],
    );
  }

}
