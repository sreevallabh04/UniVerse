// ignore_for_file: unused_import

import 'package:application/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniVerse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
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
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: Consumer<AuthenticationProvider>(
        builder: (context, authProvider, child) {
          return FutureBuilder<bool>(
            future: authProvider.isUserSignedIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                if (snapshot.hasData && snapshot.data!) {
                  return HomeScreen();
                } else {
                  return SplashScreen();
                }
              }
            },
          );
        },
      ),
    );
  }
}
