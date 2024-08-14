import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: Colors.teal, // Use a specific color
      ),
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.teal, // Use a specific color
                  Color.fromARGB(255, 237, 240, 240), // Use another specific color
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Center content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Text
                const AnimatedText(),
                const SizedBox(
                  height: 20,
                ),
                // Animated Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 235, 238, 238), // Use backgroundColor instead of primary
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  onPressed: () {
                    // Perform action here
                  },
                  child: const Text('Get Started'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedText extends StatefulWidget {
  const AnimatedText({super.key});

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _fadeIn = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeIn!,
      child: Text(
        'Welcome to UniVerse!',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white, // Use white color for text
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
