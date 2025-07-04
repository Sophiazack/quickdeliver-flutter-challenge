import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService extends ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  CollectionReference<Map<String, dynamic>> get ordersCollection =>
      _firestore.collection('orders');

  
  Future<void> createOrder({
    required String pickupLocation,
    required String dropOffLocation,
    required String packageDetails,
  }) async {
    if (userId == null) {
      throw Exception('User not logged in');
    }

    await ordersCollection.add({
      'userId': userId,
      'pickupLocation': pickupLocation,
      'dropOffLocation': dropOffLocation,
      'packageDetails': packageDetails,
      'status': 'pending',
      'timestamp': FieldValue.serverTimestamp(),
    });

    
  }

  /// getall current user's orders
  Stream<List<Map<String, dynamic>>> getUserOrders() {
    if (userId == null) {
      throw Exception('User not logged in');
    }

    return ordersCollection
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc.data()..['id'] = doc.id).toList());
  }

  /// Get order details by ID
  Future<Map<String, dynamic>?> getOrderById(String orderId) async {
    final doc = await ordersCollection.doc(orderId).get();
    if (doc.exists) {
      return doc.data()!..['id'] = doc.id;
    }
    return null;
  }

  /// Update order status
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await ordersCollection.doc(orderId).update({
      'status': newStatus,
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }
}
