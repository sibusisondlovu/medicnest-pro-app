import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/new_request_component.dart';
import '../models/request_model.dart';
import '../services/firebase_service.dart';

class AllRequestsPage extends StatefulWidget {
  const AllRequestsPage({super.key});

  @override
  State<AllRequestsPage> createState() => _AllRequestsPageState();
}

class _AllRequestsPageState extends State<AllRequestsPage> {

  late FirebaseService _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = FirebaseService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Request>>(
        stream: _firebaseService.getRequestsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Request>? requests = snapshot.data;
            if (requests == null || requests.isEmpty) {
              return const Center(child: Text('No requests available'));
            }
            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                Request request = requests[index];
                return RequestTileComponent(
                  requestType: request.typeOfRequest,
                  requestTypeIcon: request.typeOfRequest == 'video'? Icons.video_call: Icons.chat,
                  requesterName: request.requesterName,
                  requestDate: request.requestDateTime,
                  onReject: () {
                    // Handle reject request
                    if (kDebugMode) {
                      print('Rejecting request ${request.requestId}');
                    }
                  },
                  onAccept: () {
                    // Handle accept request
                    if (kDebugMode) {
                      print('Accepting request ${request.requestId}');
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
