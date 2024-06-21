import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicnest_pro/components/custom_button_component.dart';

import '../components/loading_data_component.dart';
import '../models/hpcsa_model.dart';
import '../services/firebase_service.dart';
import '../utils/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String id = 'registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final  FirebaseService _firebaseService = FirebaseService();
  final TextEditingController registrationNumberController = TextEditingController();
  bool isLoading = false;

  Future<void> _sendOTP(String hpcsaNumber) async {
    setState(() {
      isLoading = true;
    });

    try {
      DocumentSnapshot userSnapshot =
      await _firebaseService.getUserByHPCSANumber(hpcsaNumber);

      final Hpcsa hpcsa = Hpcsa.fromSnapshot(userSnapshot);

      if (userSnapshot.exists) {
        await _firebaseService.sendVerificationCode(hpcsa.number);
        Navigator.pushNamed(context, 'otpScreen', arguments: hpcsa );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('User not found for HPCSA number'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching user data: $error');
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to fetch user data'),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/logo.png', width: 200,),
                const Text('Register', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                const Text('Before we create your account, we need to verify your registration with HPCSA'),
                const SizedBox(height: 50,),
                TextFormField(
                  controller: registrationNumberController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.work,
                      ),
                      labelText: 'HPCSA Number',
                      hintText: 'Enter your HPCSA Registration Number',
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your HPCSA Registration Number';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                const Text(
                  'By clicking SEND OTP your agree to MedicNest'
                      ' Terms and Conditions, Data Usage '
                      'Policy found at www.medicnest.co.za/legal',
                  style: TextStyle(fontSize: 10),
                ),
                const SizedBox(height: 50,),
                CustomElevatedButton(text: 'SEND OTP', onPressed: (){
                  _sendOTP(registrationNumberController.text.trim());
                }),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'loginScreen');
                      },
                      child: const Text.rich(
                          TextSpan(text: 'HAVE AN ACCOUNT?', children: [
                            TextSpan(
                                text: ' LOGIN',
                                style: TextStyle(color: AppColors.mainColor))
                          ]))),
                )
              ],
            ),
          ),
          isLoading? const LoadingDataComponent(loadingText: 'Verifying \nHPCSA Registration Number...',): Container()
        ],
      )
    );
  }
}
