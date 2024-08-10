import 'package:application/domain/authentication_provider.dart';
import 'package:application/views/home_screen.dart';
import 'package:application/views/htmlWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start the login process after 3 seconds
    Future.delayed(Duration(seconds: 3), login);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> login() async {
    try {
      AuthenticationProvider authenticationProvider =
          Provider.of<AuthenticationProvider>(context, listen: false);
      await authenticationProvider.signInWithGoogle(context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomeScreen()),
          (Route route) => false);
    } catch (e) {
      // Handle error (e.g., show a message or stay on the splash screen)
    }
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
