import 'package:flutter/material.dart';
import 'package:medicnest_pro/models/hpcsa_model.dart';

import '../components/custom_button_component.dart';
import '../components/loading_spinner_component.dart';
import '../services/firebase_service.dart';
import '../utils/app_colors.dart';

class SetEmailPasswordScreen extends StatefulWidget {
  const SetEmailPasswordScreen({super.key, required this.hpcsa});
  static const String id = "setEmailPasswordScreen";
  final Hpcsa hpcsa;

  @override
  State<SetEmailPasswordScreen> createState() => _SetEmailPasswordScreenState();
}

class _SetEmailPasswordScreenState extends State<SetEmailPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool agreeToAll = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool isBusy = false;

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
                'Lets get started',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Create MedicNest Account',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 35,
              ),
              TextFormField(
                readOnly: true,
                textInputAction: TextInputAction.next,
                initialValue:
                    "${widget.hpcsa.title} ${widget.hpcsa.names} ${widget.hpcsa.surname}",
                decoration: InputDecoration(
                    labelText: 'Full Names',
                    prefixIcon: const Icon(Icons.account_circle),
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
                obscureText: _obscurePassword,
                controller: _passwordController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: 'Create Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
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
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                controller: _confirmPasswordController,
                textInputAction: TextInputAction.next,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
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
              Row(
                children: [
                  Checkbox(
                    value: agreeToAll,
                    onChanged: (bool? value) {
                      setState(() {
                        agreeToAll = value ?? false;
                      });
                    },
                  ),
                  const Flexible(
                    child: Text(
                      'I agree to all Terms and Conditions, Privacy Policy, and Data Usage Policy',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              isBusy
                  ? const CustomLoadingSpinner()
                  : CustomElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (agreeToAll) {
                            setState(() {
                              isBusy = true;
                            });

                            final FirebaseService firebaseService =
                                FirebaseService();
                            bool result = await firebaseService
                                .createUserWithEmailAndPassword(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                    widget.hpcsa);

                            if (result){
                              Navigator.pushReplacementNamed(context, 'loginScreen');
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    "An error occurred. Please try again",
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  duration: const Duration(
                                      seconds:
                                          3), // Adjust the duration as needed
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  action: SnackBarAction(
                                    label: 'OK',
                                    onPressed: () {
                                      // Add any action here if needed
                                    },
                                    textColor: Colors.white,
                                  ),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  "You must agree to all Terms and Conditions, Privacy Policy, and Data Usage Policy",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                duration: const Duration(
                                    seconds:
                                        3), // Adjust the duration as needed
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                action: SnackBarAction(
                                  label: 'OK',
                                  onPressed: () {
                                    // Add any action here if needed
                                  },
                                  textColor: Colors.white,
                                ),
                              ),
                            );
                          }
                        }
                      },
                      text: 'CREATE ACCOUNT'),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'loginScreen');
                    },
                    child: const Text.rich(TextSpan(
                        text: 'HAVE AN ACCOUNT?',
                        children: [
                          TextSpan(
                              text: ' LOGIN',
                              style: TextStyle(color: AppColors.mainColor))
                        ]))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
