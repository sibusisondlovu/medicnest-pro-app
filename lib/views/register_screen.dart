import 'package:flutter/material.dart';
import 'package:medicnest_pro/components/custom_button_component.dart';

import '../utils/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String id = 'registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController hpcsNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logo.png', width: 200,),
            Text('Register', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            Text('Why register'),
            SizedBox(height: 50,),
            TextFormField(
              controller: hpcsNumberController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.work,
                  ),
                  labelText: 'HPCSA Number',
                  hintText: 'Enter your HPCSA Number',
                  border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your HPCSA Number';
                }
                // Add email format validation if needed
                return null;
              },
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.mail,
                  ),
                  labelText: 'Email Address',
                  hintText: 'Enter your email address',
                  border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your HPCSA Number';
                }
                // Add email format validation if needed
                return null;
              },
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  labelText: 'Create Password',
                  hintText: 'Enter your your password',
                  border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please create a password';
                }
                // Add email format validation if needed
                return null;
              },
            ),
            SizedBox(height: 20,),
            const Text(
              'By clicking CREATE ACCOUNT your agree to MedicNest'
                  ' Terms and Conditions, Data Usage '
                  'Policy found at www.medicnest.co.za/legal',
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(height: 50,),
            CustomElevatedButton(text: 'CREATE ACCOUNT', onPressed: (){}),
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
    );
  }
}
