import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maverick2245/screens/ForgotPassword.dart';
import 'package:maverick2245/screens/Home.dart';
import 'package:maverick2245/screens/LoginPage.dart';
import 'package:maverick2245/screens/OTPLogin.dart';
import 'package:maverick2245/screens/OTPPin.dart';
import 'package:maverick2245/screens/SignUp.dart';

class Routes {
  // Route name constants
  static const String Home = '/HomeScreen';
  static const String LoginPage = '/Login';
  static const String SignUp = '/SignUp';
  static const String Otp = '/Otp';
  static const String Pin = '/Pin';
  static const String Forget = '/Forget';

  /// The map used to define our routes, needs to be supplied to [MaterialApp]
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.Home: (context) => HomeScreen(),
      Routes.LoginPage: (context) => Login(),
      Routes.SignUp: (context) => SignIn(),
      Routes.Otp: (context) => OtpLogin(),
      Routes.Pin: (context) => OtpPin(context),
      Routes.Forget: (context) => ForgetPassword(),
    };
  }
}
