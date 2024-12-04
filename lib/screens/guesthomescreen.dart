import 'package:airbnbmc/screens/guest_home_screens/guestexplorer.dart';
import 'package:airbnbmc/screens/guest_home_screens/guesttrips.dart'; // Import TripsScreen
import 'package:airbnbmc/screens/loginscreen.dart';
import 'package:airbnbmc/screens/profile_page';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GuestHomeScreen extends StatefulWidget {
  @override
  _GuestHomeScreenState createState() => _GuestHomeScreenState();
}

class _GuestHomeScreenState extends State<GuestHomeScreen> {
  int _selectedIndex = 0; // Tracks the selected index of the bottom navigation

  // List of pages for navigation
  final List<Widget> _pages = [
    GuestExplorer(), // Explore Page
    ProfilePage(), // Profile Page
    TripsScreen(), // Trips Page
  ];

  // Handle navigation between tabs
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Logout from Firebase
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              LoginScreen(), // Replace with your desired screen
        ),
      ); // Navigate to Login screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Welcome to Airbnb',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout), // Logout icon
            onPressed: () {
              // Show a confirmation dialog before logging out
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), // Close dialog
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                        _logout(context); // Perform logout
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: _pages[
          _selectedIndex], // Display the selected page based on the index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Current selected index
        onTap: _onItemTapped, // Handle tap on bottom navigation
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flight_takeoff), // Airplane icon for Trips
            label: 'Trips',
          ),
        ],
      ),
    );
  }
}
