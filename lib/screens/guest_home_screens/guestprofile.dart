import 'package:airbnbmc/models/hoteldata.dart'; // Import the Hotel model
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GuestProfile extends StatefulWidget {
  const GuestProfile({Key? key}) : super(key: key);

  @override
  _GuestProfileState createState() => _GuestProfileState();
}

class _GuestProfileState extends State<GuestProfile> {
  List<Hotel> _hotels = [];
  bool _isLoading = true;

  // Fetch hotels data from Firestore
  Future<void> fetchHotels() async {
    try {
      // Query Firestore to get the hotels collection
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('hotels').get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          // Convert DocumentSnapshot into Hotel objects
          _hotels =
              snapshot.docs.map((doc) => Hotel.fromSnapshot(doc)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching hotels: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchHotels(); // Fetch hotels when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guest Profile'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hotels.isEmpty
              ? const Center(child: Text('No Hotels Available'))
              : ListView.builder(
                  itemCount: _hotels.length,
                  itemBuilder: (context, index) {
                    var hotel = _hotels[index];
                    var firstImageUrl =
                        hotel.images.isNotEmpty ? hotel.images[0] : '';

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(firstImageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hotel.name,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(hotel.location,
                                    style: const TextStyle(fontSize: 18)),
                                const SizedBox(height: 8),
                                Text('Price: \$${hotel.price}',
                                    style: const TextStyle(fontSize: 18)),
                                const SizedBox(height: 8),
                                Text(hotel.description,
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
