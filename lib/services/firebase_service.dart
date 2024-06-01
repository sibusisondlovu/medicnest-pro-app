import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/request_model.dart';

class FirebaseService {
  final CollectionReference _requestsCollection =
  FirebaseFirestore.instance.collection('requests');
  final CollectionReference _hpcsaCollection =
  FirebaseFirestore.instance.collection('hpcsa');

  Stream<List<Request>> getRequestsStream() {
    return _requestsCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Request.fromFirestore(doc))
        .toList());
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserByHPCSANumber(String hpcsaNumber) {
    return FirebaseFirestore.instance.collection('hpcsa').doc(hpcsaNumber).get();
  }

  Future<bool> verifyRegistrationAndSendOTP({
    required String hpcsaNumber,
    required String idNumber,
    required String cellNumber,
  }) async {
    try {
      // Check if user exists with the provided details
      QuerySnapshot querySnapshot = await _hpcsaCollection
          .where('hpcsa', isEqualTo: hpcsaNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // User found, send OTP to the registered cell number
        String registeredCellNumber = querySnapshot.docs.first['cellNumber'];

        // Example OTP sending mechanism (replace with your actual OTP sending logic)
       // await _sendOTP(registeredCellNumber);

        return true; // Verification and OTP sending successful
      } else {
        return false; // User not found with provided details
      }
    } catch (e) {
      throw Exception('Failed to verify registration: $e');
    }
  }

  Future<void> addRequest(Request request) async {
    try {
      await _requestsCollection.doc(request.requestId).set(request.toMap());
      if (kDebugMode) {
        print('Request added successfully!');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding request: $e');
      }
    }
  }

  Future<void> updateRequest(Request request) async {
    try {
      await _requestsCollection.doc(request.requestId).update(request.toMap());
      if (kDebugMode) {
        print('Request updated successfully!');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating request: $e');
      }
    }
  }

  Future<void> deleteRequest(String requestId) async {
    try {
      await _requestsCollection.doc(requestId).delete();
      if (kDebugMode) {
        print('Request deleted successfully!');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting request: $e');
      }
    }
  }
}
