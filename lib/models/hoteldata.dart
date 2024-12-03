import 'package:cloud_firestore/cloud_firestore.dart';

class Hotel {
  final String description;
  final List<String> images;
  final String location;
  final String name;
  final double price;
  final double rating;  // Rating field

  // Constructor
  Hotel({
    required this.description,
    required this.images,
    required this.location,
    required this.name,
    required this.price,
    required this.rating,  // Rating is still here
  });

  // Factory constructor to create a Hotel object from a Map (e.g., from Firestore document)
  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      description: map['description'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      location: map['location'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0, // Ensure it's a double
      rating: map['rating']?.toDouble() ?? 0.0, // Default to 0.0 if missing
    );
  }

  // Method to convert Hotel object to Map (for storing in Firestore)
  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'images': images,
      'location': location,
      'name': name,
      'price': price,
      'rating': rating,  // Add rating to Map
    };
  }

  // Factory constructor to create a Hotel object from Firestore DocumentSnapshot
  factory Hotel.fromSnapshot(DocumentSnapshot snapshot) {
    // Convert the snapshot data to a map
    final data = snapshot.data() as Map<String, dynamic>;

    return Hotel(
      description: data['description'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      location: data['location'] ?? '',
      name: data['name'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      rating: data['rating']?.toDouble() ?? 0.0,  // Handle rating field
    );
  }
}
