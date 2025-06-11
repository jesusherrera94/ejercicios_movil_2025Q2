import 'package:cloud_firestore/cloud_firestore.dart';

class Db {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<dynamic> saveSubscription(Map<String, dynamic> subscription) async {
    try {
     final subscriptionData = await _db.collection('subscriptions').add(subscription);
      final subscriptionSnapshot = await subscriptionData.get();
      print('Order saved with id: ${subscriptionSnapshot.toString()}');
      return subscriptionSnapshot;
    } catch (e) {
      print('error ocurred calling Firebase!: $e');
      return null;
    }
  }

  void setListenerToOrder({required Function(Map<String, dynamic>) onSubscriptionRecieved}) {
    _db.collection('subscriptions').snapshots().listen((snapshot) {
      for (var doc in snapshot.docChanges) {
        if (doc.type == DocumentChangeType.modified) {
          print('subscription received: ${doc.doc.id}');
          final subscription = {
            'id': doc.doc.id,
            ...doc.doc.data() as Map<String, dynamic>,
          };
          onSubscriptionRecieved(subscription);
        }
      }
    });
  }

  Future<List<Map<String, dynamic>>> getSubscriptions(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db.collection('subscriptions').where('userId', isEqualTo: userId).get();
      List<Map<String, dynamic>> orders = querySnapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data(),
      }).toList();
      print('subscriptions received: $orders');
      return orders;
    } catch (e) {
      print('error ocurred calling Firebase!: $e');
      return [];
    }
  }

  Future<void> deleteSubscription(String subscriptionId) async {
  try {
    await _db.collection('subscriptions').doc(subscriptionId).delete();
    print('Subscription deleted: $subscriptionId');
  } catch (e) {
    print('Error deleting subscription: $e');
  }
}

}