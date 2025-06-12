import 'package:flutter/material.dart';
import '../models/subscription.dart';
import '../utils/time_utils.dart';
import '../adapters/db.dart';
import '../state/subscriptions_state.dart';

class SubscriptionItem extends StatelessWidget {
  final Subscription subscriptionElement;
  // prop drilling
  const SubscriptionItem({super.key, required this.subscriptionElement});

  Future<void> _deleteSubscription(BuildContext context) async {
    final db = Db();

    final confirm = await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Subscription?'),
            content: const Text(
              'Are you sure you want to delete this subscription?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
    if (confirm != true) return;
    await db.deleteSubscription(subscriptionElement.id);

    final updatedList = List<Subscription>.from(subscriptionsNotifier.value)
      ..removeWhere((s) => s.id == subscriptionElement.id);
    subscriptionsNotifier.value = updatedList;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Subscription Deleted!')));
  }

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
                Text(subscriptionElement.renovationCycle.name),
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
        trailing: IconButton(
          onPressed: () => _deleteSubscription(context),
          icon: Icon(
            Icons.delete,
            color: const Color.fromARGB(255, 205, 61, 61),
          ),
        ),
      ),
    );
  }
}
