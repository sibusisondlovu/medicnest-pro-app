import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDataComponent extends StatefulWidget {
  const LoadingDataComponent({super.key, required this.loadingText});
  final String loadingText;

  @override
  State<LoadingDataComponent> createState() => _LoadingDataComponentState();
}

class _LoadingDataComponentState extends State<LoadingDataComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5), // Semi-transparent black background
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitRotatingCircle(
              color: Colors.white,
              size: 50.0,
            ),
            const SizedBox(height: 20.0),
            Text(
              widget.loadingText,
              style: const TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
