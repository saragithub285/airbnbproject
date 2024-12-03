import 'package:airbnbmc/screens/guest_home_screens/guestexplorer.dart';
import 'package:airbnbmc/screens/guest_home_screens/guestprofile.dart';
import 'package:airbnbmc/screens/guest_home_screens/guesttrips.dart'; // Import TripsScreen
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
    GuestProfile(), // Profile Page
    TripsScreen(), // Trips Page
  ];

  // Handle navigation between tabs
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          ' ',
          style: TextStyle(color: Colors.white),
        ),
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
