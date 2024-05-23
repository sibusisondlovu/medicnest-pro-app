import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/onboarding_screen.dart';
import 'app_colors.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});
  static const String id = 'wrapper';

  @override
  State<Wrapper> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkFirstTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator while checking
          return const Scaffold(body: Center(child: CircularProgressIndicator(color: AppColors.mainColor, strokeWidth: 2,)));
        } else if (snapshot.hasError) {
          // Handle any errors
          return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
        } else {
          // Decide where to navigate based on the result
          final bool isFirstTime = snapshot.data!;
          return isFirstTime ? const OnBoardingScreen() : const OnBoardingScreen();
        }
      },
    );
  }

  Future<bool> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('first_time') ?? true; // Default value is true if key doesn't exist
  }
}
