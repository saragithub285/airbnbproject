import 'package:cloud_firestore/cloud_firestore.dart';

class Hotel {
  final String description;
  final List<String> images;
  final String location;
  final String name;
  final double price;

  // Constructor
  Hotel({
    required this.description,
    required this.images,
    required this.location,
    required this.name,
    required this.price,
  });

  // Factory constructor to create a Hotel object from a Map (e.g., from Firestore document)
  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      description: map['description'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      location: map['location'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0, // Ensure it's a double
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
    );
  }
}
