// dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subscriptionsapp/models/subscription.dart';

void main() {
  group('Subscription', () {
    test('constructor and getters', () {
      final sub = Subscription(
        id: 'abc123',
        platformName: 'Netflix',
        renovationDate: 1700000000,
        renovationCycle: Period.MONTHLY,
        charge: 15.99,
        userId: 'user42',
      );

      expect(sub.id, 'abc123');
      expect(sub.platformName, 'Netflix');
      expect(sub.renovationDate, 1700000000);
      expect(sub.renovationCycle, Period.MONTHLY);
      expect(sub.charge, 15.99);
      expect(sub.userId, 'user42');
      expect(sub.icon, Icons.calendar_view_month);
    });

    test('setters update values', () {
      final sub = Subscription(
        id: null,
        platformName: 'Spotify',
        renovationDate: 1600000000,
        renovationCycle: Period.YEARLY,
        charge: 99.99,
        userId: null,
      );

      sub.platformName = 'YouTube Premium';
      sub.renovationDate = 1800000000;
      sub.renovationCycle = Period.WEEKLY;
      sub.charge = 7.77;
      sub.userId = 'user99';
      sub.icon = Icons.music_note;

      expect(sub.platformName, 'YouTube Premium');
      expect(sub.renovationDate, 1800000000);
      expect(sub.renovationCycle, Period.WEEKLY);
      expect(sub.charge, 7.77);
      expect(sub.userId, 'user99');
      expect(sub.icon, Icons.music_note);
    });

    test('toMap returns correct map', () {
      final sub = Subscription(
        id: 'id1',
        platformName: 'Copilot',
        renovationDate: 1234567890,
        renovationCycle: Period.DAILY,
        charge: 1.23,
        userId: 'user1',
      );
      sub.icon = Icons.code;

      final map = sub.toMap();

      expect(map['platformName'], 'Copilot');
      expect(map['renovationDate'], 1234567890);
      expect(map['renovationCycle'], 'DAILY');
      expect(map['charge'], 1.23);
      expect(map['userId'], 'user1');
      expect(map['icon'], Icons.code);
    });

    test('fromMap creates correct Subscription', () {
      final map = {
        'id': 'id2',
        'platformName': 'YT Premium',
        'renovationDate': 987654321,
        'renovationCycle': 'YEARLY',
        'charge': 20.0,
        'userId': 'user2',
      };

      final sub = Subscription.fromMap(map);

      expect(sub.id, 'id2');
      expect(sub.platformName, 'YT Premium');
      expect(sub.renovationDate, 987654321);
      expect(sub.renovationCycle, Period.YEARLY);
      expect(sub.charge, 20.0);
      expect(sub.userId, 'user2');
    });

    test('fromMap handles missing/unknown renovationCycle', () {
      final map = {
        'id': 'id3',
        'platformName': 'Unknown',
        'renovationDate': 111111111,
        'renovationCycle': 'INVALID',
        'charge': 0.0,
        'userId': 'user3',
      };

      final sub = Subscription.fromMap(map);

      expect(sub.renovationCycle, Period.NONE);
    });

    test('getters handle null id and userId', () {
      final sub = Subscription(
        id: null,
        platformName: 'Test',
        renovationDate: 0,
        renovationCycle: Period.NONE,
        charge: 0.0,
        userId: null,
      );

      expect(sub.id, '');
      expect(sub.userId, '');
    });

    test('icon getter returns default if not set', () {
      final sub = Subscription(
        id: 'id4',
        platformName: 'Test2',
        renovationDate: 222222222,
        renovationCycle: Period.DAILY,
        charge: 2.22,
        userId: 'user4',
      );

      expect(sub.icon, Icons.calendar_view_month);
    });
  });
}