import 'package:flutter/material.dart';
import 'package:practica1/screens/counter_screen.dart';
import 'package:practica1/screens/login_screen.dart';
import 'package:practica1/screens/main_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: LoginScreen(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/pikachu.png",
      text: "Splash Screen",
      textType: TextType.ScaleAnimatedText,
      textStyle: TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: Colors.white,
    );
  }
}