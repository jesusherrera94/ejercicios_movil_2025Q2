// dart
import 'package:flutter_test/flutter_test.dart';
import 'package:subscriptionsapp/models/user.dart';

void main() {
  group('User', () {
    test('constructor assigns all fields', () {
      final user = User(
        id: 'u1',
        username: 'testuser',
        fullname: 'Test User',
        email: 'test@example.com',
        password: 'secret',
        principalInterest: 'coding',
        profilePicture: 'pic.png',
        uid: 'firebase-uid',
      );

      expect(user.id, 'u1');
      expect(user.username, 'testuser');
      expect(user.fullname, 'Test User');
      expect(user.email, 'test@example.com');
      expect(user.password, 'secret');
      expect(user.principalInterest, 'coding');
      expect(user.profilePicture, 'pic.png');
      expect(user.uid, 'firebase-uid');
    });

    test('toMap returns correct map', () {
      final user = User(
        id: 'u2',
        username: 'alice',
        fullname: 'Alice Doe',
        email: 'alice@example.com',
        password: 'pw',
        principalInterest: 'music',
        profilePicture: 'alice.png',
        uid: 'uid2',
      );

      final map = user.toMap();

      expect(map['username'], 'alice');
      expect(map['fullname'], 'Alice Doe');
      expect(map['email'], 'alice@example.com');
      expect(map['password'], 'pw');
      expect(map['principalInterest'], 'music');
      expect(map['profilePicture'], 'alice.png');
      expect(map.containsKey('id'), false);
      expect(map.containsKey('uid'), false);
    });

    test('toMapString contains all fields', () {
      final user = User(
        id: 'u3',
        username: 'bob',
        fullname: 'Bob Smith',
        email: 'bob@example.com',
        password: 'pw2',
        principalInterest: 'sports',
        profilePicture: 'bob.png',
        uid: 'uid3',
      );

      final str = user.toMapString();

      expect(str.contains('"id": "u3"'), true);
      expect(str.contains('"username": "bob"'), true);
      expect(str.contains('"fullname": "Bob Smith"'), true);
      expect(str.contains('"email": "bob@example.com"'), true);
      expect(str.contains('"principalInterest": "sports"'), true);
      expect(str.contains('"profilePicture": "bob.png"'), true);
      expect(str.contains('"uid": "uid3"'), true);
    });

    test('fromMap creates correct User', () {
      final map = {
        'id': 'u4',
        'username': 'eve',
        'fullname': 'Eve Adams',
        'email': 'eve@example.com',
        'password': 'pw3',
        'principalInterest': 'art',
        'profilePicture': 'eve.png',
        'uid': 'uid4',
      };

      final user = User.fromMap(map);

      expect(user.id, 'u4');
      expect(user.username, 'eve');
      expect(user.fullname, 'Eve Adams');
      expect(user.email, 'eve@example.com');
      expect(user.password, 'pw3');
      expect(user.principalInterest, 'art');
      expect(user.profilePicture, 'eve.png');
      expect(user.uid, 'uid4');
    });

    test('fromMap handles missing/empty optional fields', () {
      final map = {
        'username': 'noPic',
        'fullname': 'No Picture',
        'email': 'no@pic.com',
        'password': 'pw4',
        'principalInterest': 'none',
      };

      final user = User.fromMap(map);

      expect(user.id, '');
      expect(user.profilePicture, '');
      expect(user.uid, '');
      expect(user.username, 'noPic');
      expect(user.fullname, 'No Picture');
      expect(user.email, 'no@pic.com');
      expect(user.password, 'pw4');
      expect(user.principalInterest, 'none');
    });
  });
}