import 'package:flutter/material.dart';

import '../views/create_account_screen.dart';
import '../views/home_screen.dart';
import '../views/login_screen.dart';
import '../views/onboarding_screen.dart';
import '../views/otp_screen.dart';
import '../views/register_screen.dart';
import '../views/set_email_password_screen.dart';
import '../views/welcome_screen.dart';
import 'wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
    switch (settings.name) {

      case Wrapper.id:
        return _route(const Wrapper());

      case OnBoardingScreen.id:
        return _route(const OnBoardingScreen());

      case WelcomeScreen.id:
        return _route(const WelcomeScreen());

      case RegisterScreen.id:
        return _route(const RegisterScreen());

      case HomeScreen.id:
        return _route(const HomeScreen());
      case OTPScreen.id:
        return _route(OTPScreen(data: args,));

      case CreateAccountScreen.id:
        return _route(const CreateAccountScreen());

      case SetEmailPasswordScreen.id:
        return _route(SetEmailPasswordScreen(hpcsa: args,));

      case LoginScreen.id:
        return _route(const LoginScreen());

      // case RegisterScreen.id:
      //   return _route(const RegisterScreen());

      // case LoginScreen.id:
      //   return _route(const LoginScreen());

      // case HomeScreen.id:


      default:
        return _errorRoute(settings.name);
    }
  }

  static MaterialPageRoute _route(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);

  static Route<dynamic> _errorRoute(String? name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            )
          ],
        ),
        body: Center(
          child: Text(
            'ROUTE \n\n$name\n\nNOT FOUND',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
