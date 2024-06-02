import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomLoadingSpinner extends StatelessWidget {
  const CustomLoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        child: Column(
          children: [
            CircularProgressIndicator(
              strokeWidth: 2, // Set stock width to 1
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.mainColor), // Set color to primary
            ),
            SizedBox(height: 15,),
            Text('Please wait...', style: TextStyle(fontSize: 10),)
          ],
        ),
      ),
    );
  }
}