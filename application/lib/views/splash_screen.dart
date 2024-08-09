import 'package:application/views/home_screen.dart';
import 'package:application/views/htmlWidget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next screen after 4 seconds
    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            HomeScreen(), // Replace with your home screen widget
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Center(child: AnimatedTextWidget(text: "UniVerse")),
    );
  }
}
