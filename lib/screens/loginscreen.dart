import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:airbnbmc/screens/signupscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers to handle text input from email and password fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Set background color of the Scaffold to white
      body: Center(  // Center everything inside the body of the screen
        child: ListView(
          padding: EdgeInsets.all(20),  // Padding around the ListView
          children: [
            SizedBox(height: 50),  // Adds space at the top
            // Image positioned at the top
            Center(  // Ensures the image is centered horizontally
              child: Image.asset(
                "images/airbnblogo1.png",
                width: 100,  // Sets the width for the logo image
                height: 100, // Ensures the logo is not too big
              ),
            ),
            SizedBox(height: 20),  // Adds space between the image and text
            // Text positioned below the image
            Text(
              'Welcome to Airbnb',
              style: TextStyle(
                fontWeight: FontWeight.bold,   // Bold text
                fontSize: 28,                  // Larger text for prominence
                color: Colors.black,           // Black text color
                letterSpacing: 2.0,            // Space between letters for a clean look
              ),
              textAlign: TextAlign.center,    // Centers the text horizontally
            ),
            SizedBox(height: 40),  // Adds space between text and form fields
            // Email input field
            TextField(
              controller: emailController,  // To access the email input value
              decoration: InputDecoration(
                labelText: 'Email',          // Label for the email input
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade100),  // Light red border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade300),  // Darker red when focused
                ),
                filled: true,  // Makes the background of the input field filled
                fillColor: Colors.red.shade50,  // Light red background
              ),
              keyboardType: TextInputType.emailAddress,  // Ensures email keyboard on mobile
            ),
            SizedBox(height: 20),  // Adds space between email and password fields
            // Password input field
            TextField(
              controller: passwordController,  // To access the password input value
              decoration: InputDecoration(
                labelText: 'Password',          // Label for the password input
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade100),  // Light red border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade300),  // Darker red when focused
                ),
                filled: true,  // Makes the background of the input field filled
                fillColor: Colors.red.shade50,  // Light red background
              ),
              obscureText: true,  // Hides the password text
            ),
            SizedBox(height: 30),  // Adds space between password field and login button
            // Login button
            ElevatedButton(
              onPressed: () {
                // Add login logic here
                String email = emailController.text;
                String password = passwordController.text;
                // You can now use the email and password for authentication
                print("Email: $email, Password: $password");
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),  // White text color for the Login button
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,  // Button color
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),  // Button padding
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  // Button text style
              ),
            ),
            SizedBox(height: 20),  // Adds space between login button and the Sign Up message
            // Sign Up message in red
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigate to Sign Up screen using GetX
                  Get.to(() => SignUpScreen()); // Use Get.to() to navigate
                },
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(
                    color: Colors.red,  // Red text color for the Sign Up message
                    fontSize: 16,        // Font size for the message
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

