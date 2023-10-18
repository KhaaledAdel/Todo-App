import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_app/Screens/Login/LoginScreen.dart';
import '../../layout/Home_layout/home_layout.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "Splash_Screen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 3),
          () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
    );
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Image.asset("assets/images/SplashScreenlight.png",
          width: mediaQuery.width,
          height: mediaQuery.height,
          fit: BoxFit.cover),
    );
  }
}