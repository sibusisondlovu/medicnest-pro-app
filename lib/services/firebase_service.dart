import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:medicnest_pro/models/hpcsa_model.dart';
import 'package:medicnest_pro/utils/app_colors.dart';
import '../models/request_model.dart';

class FirebaseService {
  final CollectionReference _requestsCollection =
  FirebaseFirestore.instance.collection('requests');
  final CollectionReference _hpcsaCollection =
  FirebaseFirestore.instance.collection('hpcsa');
  final CollectionReference _practitionersCollection =
  FirebaseFirestore.instance.collection('practitioners');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Request>> getRequestsStream() {
    return _requestsCollection
        .where('practitionerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Request.fromFirestore(doc))
        .toList());
  }


  Future<bool> createUserWithEmailAndPassword(
      String email, String password, Hpcsa hpcsa) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _practitionersCollection.doc(userCredential.user!.uid).set({
        'email': email,
        'hpcsa': hpcsa.number,
        'title': hpcsa.title,
        'avatar': 'avatar.png',
        'status': 'Not Available',
        'speciality': hpcsa.field,
        'qualification': hpcsa.qualification,
        'names': hpcsa.names,
        'surname': hpcsa.surname,
        'cellNumber': hpcsa.number,
      });

      await userCredential.user!.updateDisplayName(
          "${hpcsa.title} ${hpcsa.names} ${hpcsa.surname}");
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error creating user: $e');
      }
      return false;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserByHPCSANumber(String hpcsaNumber) {
    return FirebaseFirestore.instance.collection('hpcsa').doc(hpcsaNumber).get();
  }

  Future<void> sendVerificationCode(String cellNumber) async {
    try {
      final Uri uri = Uri.parse('${AppColors.cloudFunctionsUrl}/sendVerificationCode');

      if (cellNumber.startsWith('0')) {

        final response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'phoneNumber': '+27${cellNumber.substring(1)}',
          }),
        );

         if (response.statusCode == 200) {
           if (kDebugMode) {
             print('Verification code sent successfully');
           }
           // Handle success as needed
         } else {
           if (kDebugMode) {
             print(cellNumber);
             print('Failed to send verification code. Status code: ${response.statusCode} \nwith error ${response.body}');
           }
           // Handle failure as needed
         }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error sending verification code: $error');
      }
    }
  }

  Future<void> verifyOtp(String verificationCode, String phoneNumber) async {
    try {
      final Uri uri = Uri.parse('${AppColors.cloudFunctionsUrl}/verifyCode');

      if (phoneNumber.startsWith('0')) {

        final response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'phoneNumber': '+27${phoneNumber.substring(1)}',
            'code': verificationCode,
          }),
        );

        if (response.statusCode == 200) {
          if (kDebugMode) {
            print('Verification code sent successfully');
          }

        } else {
          if (kDebugMode) {
            print('Failed to send verification code. Status code: ${response.statusCode}');
          }
          // Handle failure as needed
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error sending verification code: $error');
      }
    }
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
        String registeredCellNumber = querySnapshot.docs.first['cellNumber'];
       await sendVerificationCode(registeredCellNumber);

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
