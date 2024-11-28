import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  // Get user details
  User? get user => _user;

  // Set user details
  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  // Check if the user is logged in
  bool get isLoggedIn => _user != null;

  // Sign in user (For demonstration)
  Future<void> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to sign in, wrong credentials');
    }
  }

  // Sign out user
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }

  // Initialize user based on Firebase Auth state
  Future<void> initialize() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _user = currentUser;
    }
    notifyListeners();
  }
}
