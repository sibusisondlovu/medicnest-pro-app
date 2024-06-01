import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicnest_pro/components/custom_button_component.dart';
import 'package:medicnest_pro/models/hpcsa_model.dart';
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
              'Dont have access to this number? \nContact HPCSA to update',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.0),
            ),
            const SizedBox(height: 20.0),
          Pinput(
            controller: pinController,
            // defaultPinTheme: defaultPinTheme,
            // focusedPinTheme: focusedPinTheme,
            //submittedPinTheme: submittedPinTheme,
            validator: (s) {
              return s == '2222' ? null : 'Pin is incorrect';
            },
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) => print(pin),
          ),
            const SizedBox(height: 20.0),
            CustomElevatedButton(
              onPressed: () {
                print(pinController.text);
              },
              text: 'VERIFY OTP',
            ),
          ],
        ),
      ),
    );
  }
}
