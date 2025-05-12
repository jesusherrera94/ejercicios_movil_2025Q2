import 'package:bottomnavbar/widgets/subscription_item.dart';
import 'package:flutter/material.dart';
import '../models/subscription.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  // temporal final!
  final List<Subscription> _subscriptions = [
    Subscription(
      id: '1',
      platformName: 'Netflix',
      renovationDate: 2148483647, 
      renovationCycle: Period.MONTHLY,
      charge: 12.99,
      userId: 'user123',
    ),
    Subscription(
      id: '2',
      platformName: 'Spotify',
      renovationDate: 2147483647,
      renovationCycle: Period.MONTHLY,
      charge: 9.99,
      userId: 'user123',
    ),
    Subscription(
      id: '3',
      platformName: 'Hulu',
      renovationDate: 2147483647,
      renovationCycle: Period.MONTHLY,
      charge: 7.99,
      userId: 'user123',
    ),
    Subscription(
      id: '4',
      platformName: 'Amazon Prime',
      renovationDate: 2147483647,
      renovationCycle: Period.YEARLY,
      charge: 119.00,
      userId: 'user123',
    ),
    Subscription(
      id: '5',
      platformName: 'YouTube Premium',
      renovationDate: 2047483635,
      renovationCycle: Period.MONTHLY,
      charge: 11.99,
      userId: 'user123',
    ),
  ];
  Period? _selectedFilter;

  List<Widget> _renderItems() {
  List<Widget> subscriptionWidget = [];
  for(final subscription in _subscriptions) {
    subscriptionWidget.add(SubscriptionItem(subscriptionElement: subscription,));
  }
  return subscriptionWidget;
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedFilter == Period.DAILY
                          ? Colors.blueAccent 
                          : Colors.grey,
                    ), 
              child: const Text("Daily"),
              
              ),
              ElevatedButton(onPressed: () {
               
              }, 
              style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedFilter == Period.DAILY
                          ? Colors.blueAccent
                          : Colors.grey,
                    ), 
              child: const Text("Monthly")),
              ElevatedButton(onPressed: () {
               
              }, 
              style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedFilter == Period.DAILY
                          ? Colors.blueAccent
                          : Colors.grey,
                    ), 
              child: const Text("Yearly")),
            ],
        ),
        Expanded(
      child:ListView(
        children: _renderItems(),
      )
    )
      ],
    );
  }
}