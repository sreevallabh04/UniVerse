import 'package:application/domain/authentication_provider.dart';
import 'package:application/views/home_screen.dart';
import 'package:application/views/htmlWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start the login process after 3 seconds
    Future.delayed(const Duration(seconds: 3), login);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> login() async {
    try {
      AuthenticationProvider authenticationProvider =
          Provider.of<AuthenticationProvider>(context, listen: false);

      // Start the Google sign-in process
      await authenticationProvider.signInWithGoogle(context);

      // Navigate to HomeScreen after successful sign-in
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (Route route) => false,
      );
    } catch (e) {
      // Handle exceptions during sign-in
      print('Error during sign-in: $e');
      _showErrorMessage("An error occurred. Please try again.");
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: const Center(child: AnimatedTextWidget(text: "UniVerse")),
    );
  }
}
