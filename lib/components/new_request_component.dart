import 'dart:ui';

import 'package:flutter/material.dart';

class RequestTileComponent extends StatelessWidget {
  final String requestType;
  final IconData requestTypeIcon;
  final String requesterName;
  final DateTime requestDate;
  final VoidCallback onReject;
  final VoidCallback onAccept;

  const RequestTileComponent({
    super.key,
    required this.requestType,
    required this.requestTypeIcon,
    required this.requesterName,
    required this.requestDate,
    required this.onReject,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      requesterName,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 120),
                    Icon(requestTypeIcon),
                    const SizedBox(width: 8),
                    Text(
                      requestType,
                      style: const TextStyle(

                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              '${requestDate.day}/${requestDate.month}/${requestDate.year}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Text(textAlign: TextAlign.center, 'Consultation Request', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: onReject,
                  child: const Text(
                    'Reject Request',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ), backgroundColor: Colors.green,
                  ),
                  child: const Text('Accept Request'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}