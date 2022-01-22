import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:micfi/splash_screen.dart';
import 'package:micfi/stats_screen.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'bottom.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'micfi',
      theme: ThemeData(
        // This information simply gives a brief overview of the app
        // Define the default brightness and colors.
        brightness: Brightness.light,
        // Define the default font family.
        fontFamily: 'Georgia',
        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      initialRoute: 'splash_screen',
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'login_screen': (context) => LoginScreen(),
        'main': (context)=>ButtomNav(),
        'splash_screen': (context) => Splash(),
        'home_screen': (context) => Stats(),
      },
    );
  }
}
