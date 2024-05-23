import 'package:flutter/material.dart';
import 'package:medicnest_pro/components/custom_button_component.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static const String id = 'welcomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/welcome_screen.jpg',
              fit: BoxFit.fill,
              height: 350,
            ),
            const SizedBox(height: 50,),
            Image.asset(
              'assets/images/welcome_screen_logo.png',
              height: 50,
            ),
            const Text(
              'Where Healthcare Meets Innovation',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Innovative digital platform, patients can choose their preferred healthcare provider ',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(height: 80,),
            CustomElevatedButton(text: 'LOGIN', onPressed: () {}),
            CustomOutlinedButton(text: 'REGISTER', onPressed: () {
              Navigator.pushNamed(context, 'registerScreen');
            })
          ],
        ),
      ),
    );
  }
}
