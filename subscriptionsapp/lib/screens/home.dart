import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import '../widgets/subscription_item.dart';
import '../models/subscription.dart';
import '../adapters/db.dart';
import '../adapters/local_storage.dart';
import '../models/user.dart';
import '../state/subscriptions_state.dart';
import '../adapters/notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Period? _selectedFilter;
  bool _isLoading = false;
  final Db _db = Db();
  final LocalStorage _localStorage = LocalStorage();
  late User _user;
  final Notifications _notifications = Notifications();

  @override
  void initState() {
    super.initState();
    _loadSubscriptions();
  }

  void _loadSubscriptions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userString = await _localStorage.getUserData('user');
      _user = User.fromMap(convert.jsonDecode(userString));

      final subscriptions = await _db.getSubscriptions(_user.uid!);

      subscriptionsNotifier.value =
          subscriptions.map((s) => Subscription.fromMap(s)).toList();
    } catch (error) {
      print('Error loading subscriptions: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
    _listenChanges();
  }

  void _listenChanges() {
    _db.setListenerToSubscription(
      onSubscriptionRecieved: (data) {
        final sub = Subscription.fromMap(data);
        final currentList = List<Subscription>.from(subscriptionsNotifier.value);
        final idx = currentList.indexWhere((s) => s.id == sub.id);
        if (idx != -1) {
          currentList[idx] = sub;
          _notifications.showNotification(
            title: 'Subscriptions has changed',
            body: 'Subscription ${sub.platformName} has changed');
        } else {
          currentList.add(sub);
        }
        subscriptionsNotifier.value = currentList;
      },
    );
  }

  void _selectPeriod(Period? newPeriod) {
    setState(() {
      _selectedFilter = newPeriod;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (_selectedFilter != null)
              IconButton(
                onPressed: () {
                  _selectPeriod(null);
                },
                icon: Icon(Icons.cancel),
              ),
            ElevatedButton(
              onPressed: () {
                if (_selectedFilter == Period.DAILY) {
                  _selectPeriod(null);
                } else {
                  _selectPeriod(Period.DAILY);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _selectedFilter == Period.DAILY
                        ? Colors.blueAccent
                        : Colors.grey,
              ),
              child: const Text("Daily"),
            ),
            ElevatedButton(
              onPressed: () {
                _selectPeriod(Period.MONTHLY);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _selectedFilter == Period.MONTHLY
                        ? Colors.blueAccent
                        : Colors.grey,
              ),
              child: const Text("Monthly"),
            ),
            ElevatedButton(
              onPressed: () {
                _selectPeriod(Period.YEARLY);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _selectedFilter == Period.YEARLY
                        ? Colors.blueAccent
                        : Colors.grey,
              ),
              child: const Text("Yearly"),
            ),
          ],
        ),
        Expanded(
          child: ValueListenableBuilder<List<Subscription>>(
            valueListenable: subscriptionsNotifier,
            builder: (context, subscriptions, _) {
              final filtered =
                  _selectedFilter == null
                      ? subscriptions
                      : subscriptions
                          .where((s) => s.renovationCycle == _selectedFilter)
                          .toList();
              if (filtered.isEmpty) {
                return const Center(
                  child: Text(
                    'No subscription found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }
              return ListView(
                children:
                    filtered
                        .map((s) => SubscriptionItem(subscriptionElement: s))
                        .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
