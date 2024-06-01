import 'package:cloud_firestore/cloud_firestore.dart';

class Hpcsa {
  String city;
  String code;
  String field;
  String names;
  String number;
  String obtained;
  String qualification;
  String registration;
  String status;
  String surname;
  String title;
  String type;

  Hpcsa({
    required this.city,
    required this.code,
    required this.field,
    required this.names,
    required this.number,
    required this.obtained,
    required this.qualification,
    required this.registration,
    required this.status,
    required this.surname,
    required this.title,
    required this.type,
  });

  factory Hpcsa.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    return Hpcsa(
      city: data?['city'] ?? '',
      code: data?['code'] ?? '',
      field: data?['field'] ?? '',
      names: data?['names'] ?? '',
      number: data?['number'] ?? '',
      obtained: data?['obtained'] ?? '',
      qualification: data?['qualification'] ?? '',
      registration: data?['registration'] ?? '',
      status: data?['status'] ?? '',
      surname: data?['surname'] ?? '',
      title: data?['title'] ?? '',
      type: data?['type'] ?? '',
    );
  }
}
