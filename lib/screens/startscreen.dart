import 'dart:async';  // Add this import for Timer
import 'package:airbnbmc/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';  // Assuming you want to navigate using GetX

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    // Timer to navigate after 3 seconds
    Timer(const Duration(seconds: 2), () {
      Get.to(LoginScreen()); // Replace with the actual screen you want to navigate to
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,  // Keep white background
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Welcome text
              Text(
                'Welcome to',
                style: TextStyle(
                  fontWeight: FontWeight.bold,   // Bold text
                  fontSize: 58,                  // Larger text for prominence
                  color: Colors.black,             // Red text color
                  letterSpacing: 2.0,            // Space between letters for a clean look
                ),
              ),
              SizedBox(height: 20), // Adds spacing between the text and the logo
              // Logo image
              Image.asset(
                'images/airbnblogo1.png',
                width: 200, // Sets the width for the logo image
                height: 200, // Ensures the logo is not too big
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example of a screen you can navigate to
class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Next Screen')),
      body: Center(child: Text('This is the next screen!')),
    );
  }
}
