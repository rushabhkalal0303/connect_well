import 'package:flutter/material.dart';
import '../../utils/commonMethods.dart';
import '../LoginView/view/loginView.dart';

class SplashScreenHelpers {

  static Future<void> NavigateToNextScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5));
    CallNextScreen(context, const LoginView());
  }

}
