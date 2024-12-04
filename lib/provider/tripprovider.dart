import 'package:airbnbmc/models/hoteldata.dart'; // Ensure you are importing your Hotel model
import 'package:flutter/material.dart';

class TripsProvider with ChangeNotifier {
  List<Hotel> _trips = []; // Private list of trips

  // Getter to access the trips list
  List<Hotel> get trips => _trips;

  // Method to add a hotel to the trips list
  void addTrip(Hotel hotel) {
    _trips.add(hotel); // Add the hotel to the trips list
    notifyListeners(); // Notify listeners to update the UI
  }

  // Method to remove a trip
  void removeTrip(Hotel hotel) {
    _trips.remove(hotel);
    notifyListeners();
  }

  // Method to clear all trips
  void clearTrips() {
    void clearTrips() {}
    _trips.clear(); // Clear the trips list
    notifyListeners(); // Notify listeners to update the UI
  }
}
