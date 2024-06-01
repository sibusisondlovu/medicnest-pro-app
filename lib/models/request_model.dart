import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String requestId;
  String requesterName;
  DateTime requestDateTime;
  String typeOfRequest;
  String requestIcon;
  String requesteeId;
  String status;
  String requestSubject;

  Request({
    required this.requestId,
    required this.requesterName,
    required this.requestDateTime,
    required this.typeOfRequest,
    required this.requestIcon,
    required this.requesteeId,
    required this.status,
    required this.requestSubject,
  });

  factory Request.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Request(
      requestId: doc.id,
      requesterName: data['requesterName'] ?? '',
      requestDateTime: (data['requestDateTime'] as Timestamp).toDate(),
      typeOfRequest: data['typeOfRequest'] ?? '',
      requestIcon: data['requestIcon'] ?? '',
      requesteeId: data['requesteeId'] ?? '',
      status: data['status'] ?? '',
      requestSubject: data['requestSubject'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'requesterName': requesterName,
      'requestDateTime': requestDateTime,
      'typeOfRequest': typeOfRequest,
      'requestIcon': requestIcon,
      'requesteeId': requesteeId,
      'status': status,
      'requestSubject': requestSubject,
    };
  }
}
