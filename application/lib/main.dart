import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Replace with your actual splash screen file
import 'home_screen.dart'; // Replace with your actual home screen file

void main() {
  runApp(MyApp());
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
        scaffoldBackgroundColor: Colors.white, // Background color for your app
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white, // Background color for AppBar
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue, // Default button color
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(), // Default border for input fields
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) =>
            HomeScreen(), // Replace with your actual home screen
        // Add more routes here as needed
      },
    );
  }
}
