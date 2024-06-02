import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicnest_pro/components/custom_button_component.dart';
import 'package:medicnest_pro/models/hpcsa_model.dart';
import 'package:medicnest_pro/services/firebase_service.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  final Hpcsa data;
  static const String id = 'otpScreen';

  const OTPScreen({super.key, required this.data});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final FirebaseService firebaseService = FirebaseService();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter OTP sent to ${widget.data.number}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18.0),
            ),
            const Text(
              'Don\'t have access to this number? \nContact HPCSA to update',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.0),
            ),
            const SizedBox(height: 20.0),
          Pinput(
            length: 6,
            controller: pinController,
            // defaultPinTheme: defaultPinTheme,
            // focusedPinTheme: focusedPinTheme,
            //submittedPinTheme: submittedPinTheme,
            validator: (s) {
              if (s!.isEmpty) {
                return 'Please enter OTP';
              }
              return null;
            },
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
          ),
            const SizedBox(height: 20.0),
            CustomElevatedButton(
              onPressed: () async {
               // await firebaseService.verifyOtp(pinController.text.trim(), widget.data.number);
              Navigator.pushNamed(context, 'setEmailPasswordScreen',arguments: widget.data);
              },
              text: 'VERIFY OTP',
            ),
          ],
        ),
      ),
    );
  }
}
