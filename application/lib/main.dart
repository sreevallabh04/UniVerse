// ignore_for_file: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'domain/authentication_provider.dart'; // Import your provider
import 'views/splash_screen.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthenticationProvider(), // Initialize your provider here
      builder: (context, child) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniVerse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'KairosPro',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'KairosPro',
            fontSize: 16,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.blue,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: Consumer<AuthenticationProvider>(
        builder: (context, authProvider, child) {
          return FutureBuilder<bool>(
            future: authProvider.isUserSignedIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: LoadingIndicator(
                      indicatorType: Indicator.pacman,
                      colors: [Colors.deepPurple],
                    ),
                  ),
                );
              } else {
                if (snapshot.hasData && snapshot.data!) {
                  return const HomeScreen();
                } else {
                  return const SplashScreen();
                }
              }
            },
          );
        },
      ),
    );
  }
}
