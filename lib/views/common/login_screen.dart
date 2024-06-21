import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/custom_button_component.dart';
import '../../components/loading_spinner_component.dart';
import '../../config/strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = "loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isBusy = false;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    setState(() {
      _isBusy = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('existing_user', true);
      setState(() {
        _isBusy = false;
      });
      Navigator.pushReplacementNamed(context, 'homeScreen');
    } catch (e) {
      if (kDebugMode) {
        print("Error signing in: $e");
      }

      setState(() {
        _isBusy = false;
      });

      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 70,
              ),
              const Text(
                'Welcome back',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Login to MedicNest',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 35,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email address cannot be empty";
                  }
                  return null;
                },
                controller: _emailController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: const Icon(Icons.mail),
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.red)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey))),
              ),
              const SizedBox(
                height: 15,
              ),

              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be empty";
                  }
                  return null;
                },
                obscureText: true,
                controller: _passwordController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.red)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey))),
              ),

              const SizedBox(
                height: 20,
              ),
              _isBusy? const CustomLoadingSpinner(): CustomElevatedButton(
                  onPressed: () {
                    signInWithEmailAndPassword(_emailController.text.trim(), _passwordController.text.trim());
                  },
                  text: 'LOGIN'),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'createAccountScreen');
                  },
                  child: const Text.rich(TextSpan(
                      text: 'DON\'T HAVE AN ACCOUNT?',
                      children: [
                        TextSpan(
                            text: ' REGISTER',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Strings.mainColor))
                      ])))
            ],
          ),
        ),
      ),
    );
  }
}
