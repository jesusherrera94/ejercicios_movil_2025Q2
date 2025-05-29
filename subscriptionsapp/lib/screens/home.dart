import '../widgets/subscription_item.dart';
import 'package:flutter/material.dart';
import '../models/subscription.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  Period? _selectedFilter;
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

  List<Subscription> _filteredSubscriptions = [];

  List<Widget> _renderItems() {
  List<Widget> subscriptionWidget = [];

    if(_selectedFilter == null) {
      // funciona cuando inicia el app y cuando se restaure el filtro
      // aka. estado inicial
        for(final subscription in _subscriptions) {
         subscriptionWidget.add(SubscriptionItem(subscriptionElement: subscription,));
        }
      setState(() {
        _filteredSubscriptions = _subscriptions;
      });
    } else {
      _filteredSubscriptions = _subscriptions.where((subs) {
        return subs.renovationCycle == _selectedFilter;
      }).toList();

      for(final subscription in _filteredSubscriptions) {
        subscriptionWidget.add(SubscriptionItem(subscriptionElement: subscription,));
      }
      setState(() {});
    }
  return subscriptionWidget;
}

void _selectPeriod(Period? newPeriod) {
  setState(() {
    _selectedFilter = newPeriod;
  });
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (_selectedFilter != null)
            IconButton(onPressed: () {
              _selectPeriod(null);
            }, icon: Icon(Icons.cancel)),
            ElevatedButton(onPressed: () {
              if(_selectedFilter == Period.DAILY) {
                _selectPeriod(null);
              } else {
                _selectPeriod(Period.DAILY);
              }
            }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedFilter == Period.DAILY ?
                  Colors.blueAccent : Colors.grey 
              ),
            child: const Text("Daily"),
            ),
            ElevatedButton(onPressed: () {
              _selectPeriod(Period.MONTHLY);
            }, 
            style: ElevatedButton.styleFrom(
                backgroundColor: _selectedFilter == Period.MONTHLY ?
                  Colors.blueAccent : Colors.grey 
              ),
            child: const Text("Monthly")),
            ElevatedButton(onPressed: () {
              _selectPeriod(Period.YEARLY);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: _selectedFilter == Period.YEARLY ?
                  Colors.blueAccent : Colors.grey 
              ),
             child: const Text("Yearly"))
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
