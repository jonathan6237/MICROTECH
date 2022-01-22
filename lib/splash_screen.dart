import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:micfi/welcome_screen.dart';

// This is the splash screen...... The first screen seen when launching the app
class Splash extends StatelessWidget {
  const Splash({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
          duration: 2000,
          splash: Icon(Icons.money_off_csred_rounded, color: Colors.orangeAccent, size: 100,),
          nextScreen: WelcomeScreen(),
          splashTransition: SplashTransition.fadeTransition,
        );
  }
}