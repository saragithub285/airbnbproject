import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: Colors.red, // Same color as the login page button
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title Text - Similar to Login Page
            const Text(
              'Create Account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.black,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 20),

            // First Name Field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Last Name Field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // City Field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Country Field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Email Field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Password Field
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Sign Up Button
            ElevatedButton(
              onPressed: () {
                if(!_formKey.currentState!.validate() || imageFileOfUser == null)
                Get.snackbar ("Field Missing", "Please choose image and fill out complete sign up form.");
                return;
                }

                if(_emailTextEditingController.text.isEmpty && _passwordTextEditingController.text.isEmpty)
                {
                Get.snackbar ("Field Missing", "Please fill out complete sign up form.");
                return;
                }

                UserViewModel.signUp(
                  _emailTextEditingController.text.trim(),
                  _passwordTextEditingController.text.trim(),
                  _firstNameTextEditingController.text.trim(),
                  _lastNameTextEditingController.text.trim(),
                  _cityTextEditingController.text.trim(),
                  _countryTextEditingController.text.trim(),
                  _bioTextEditingController.text.trim(),
                  imageFileOfUser,

                ):
              },


              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red button to match login page style
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              ),
              child: const Text('Create Account', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),

            // Message to have an account with link to login page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? ",
                    style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () {
                    // Navigate to Login page
                    Navigator.pop(context); // Just for demonstration. You can use Get.to() if you're using GetX.
                  },
                  child: const Text('Log in',
                      style: TextStyle(
                        color: Colors.red, // Red text to make it look clickable
                        fontSize: 16,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
