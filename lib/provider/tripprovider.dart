import 'package:flutter/material.dart';
import 'package:airbnbmc/models/hoteldata.dart'; // Ensure you are importing your Hotel model
class TripsProvider with ChangeNotifier {
  List<Hotel> _trips = [];  // Private list of trips

  // Getter to access the trips list
  List<Hotel> get trips => _trips;

  // Method to add a hotel to the trips list
  void addTrip(Hotel hotel) {
    _trips.add(hotel);  // Add the hotel to the trips list
    notifyListeners();  // Notify listeners to update the UI
  }

  // Method to remove a hotel from the list
  void removeTrip(Hotel hotel) {
    _trips.remove(hotel);  // Remove the hotel from the list
    notifyListeners();     // Notify listeners to update the UI
  }

  // Method to clear all trips
  void clearTrips() {
  void clearTrips() {}    _trips.clear();  // Clear the trips list
    notifyListeners();  // Notify listeners to update the UI
  }
}
