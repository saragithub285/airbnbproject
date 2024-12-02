import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Import provider package
import 'package:airbnbmc/models/hoteldata.dart'; // Import your Hotel model
import 'package:airbnbmc/provider/tripprovider.dart';  // Import the TripsProvider
import 'package:airbnbmc/screens/hotel_detail.dart';  // Import the new hotel detail page

class GuestExplorer extends StatefulWidget {
  const GuestExplorer({Key? key}) : super(key: key);

  @override
  _GuestExplorerState createState() => _GuestExplorerState();
}

class _GuestExplorerState extends State<GuestExplorer> {
  List<Hotel> _hotels = [];
  List<Hotel> _filteredHotels = [];
  bool _isLoading = true;
  TextEditingController _searchController = TextEditingController();

  // Price range slider variables
  double _minPrice = 0;
  double _maxPrice = 10000; // Set a higher maximum price (can be adjusted)

  // Fetch hotels data from Firestore
  Future<void> fetchHotels() async {
    try {
      // Query Firestore to get the hotels collection
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('hotels').get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          // Convert DocumentSnapshot into Hotel objects
          _hotels = snapshot.docs.map((doc) => Hotel.fromSnapshot(doc)).toList();
          _filteredHotels = List.from(_hotels);  // Initially, show all hotels
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

  // Filter the hotels based on price range and search query
  void _filterHotels(String query) {
    List<Hotel> filtered = _hotels.where((hotel) {
      return (hotel.price >= _minPrice && hotel.price <= _maxPrice) &&
          (hotel.name.toLowerCase().contains(query.toLowerCase()) ||
              hotel.location.toLowerCase().contains(query.toLowerCase()));
    }).toList();

    setState(() {
      _filteredHotels = filtered;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchHotels();  // Fetch hotels when the widget initializes
    _searchController.addListener(() {
      _filterHotels(_searchController.text);  // Filter hotels whenever the search text changes
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Hotels'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(_hotels),
                );
              },
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Display the price range only once here
                Text(
                  'Price Range: \$${_minPrice.toStringAsFixed(0)} - \$${_maxPrice.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 18),
                ),
                // Adjusting the slider to allow for a larger range
                RangeSlider(
                  min: 0,
                  max: 10000, // Increased the max value to 10000
                  divisions: 100, // Increase the divisions for finer control
                  labels: RangeLabels(
                    _minPrice.toStringAsFixed(0),
                    _maxPrice.toStringAsFixed(0),
                  ),
                  values: RangeValues(_minPrice, _maxPrice),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _minPrice = values.start;
                      _maxPrice = values.end;
                    });
                    _filterHotels(_searchController.text); // Apply filter based on new price range
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredHotels.isEmpty
                ? const Center(child: Text('No Hotels Available'))
                : ListView.builder(
              itemCount: _filteredHotels.length,
              itemBuilder: (context, index) {
                var hotel = _filteredHotels[index];
                var firstImageUrl = hotel.images.isNotEmpty ? hotel.images[0] : '';

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(hotel.location, style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 8),
                            Text('Price: \$${hotel.price}', style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Navigate to the hotel detail page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HotelDetailPage(hotel: hotel),
                                  ),
                                );
                              },
                              child: const Text('See More'),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Add the hotel to the trips list
                                Provider.of<TripsProvider>(context, listen: false).addTrip(hotel);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Added to Trips!')),
                                );
                              },
                              child: const Text('Add to Trips'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// CustomSearchDelegate for hotel search (remains unchanged)
class CustomSearchDelegate extends SearchDelegate {
  final List<Hotel> hotels;

  CustomSearchDelegate(this.hotels);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';  // Clear the search query
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Hotel> results = hotels.where((hotel) {
      return hotel.name.toLowerCase().contains(query.toLowerCase()) ||
          hotel.location.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        var hotel = results[index];
        var firstImageUrl = hotel.images.isNotEmpty ? hotel.images[0] : '';

        return ListTile(
          leading: Image.network(firstImageUrl),
          title: Text(hotel.name),
          subtitle: Text(hotel.location),
          onTap: () {
            close(context, null);  // Close the search delegate
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HotelDetailPage(hotel: hotel),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Hotel> suggestions = hotels.where((hotel) {
      return hotel.name.toLowerCase().contains(query.toLowerCase()) ||
          hotel.location.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        var hotel = suggestions[index];
        var firstImageUrl = hotel.images.isNotEmpty ? hotel.images[0] : '';

        return ListTile(
          leading: Image.network(firstImageUrl),
          title: Text(hotel.name),
          subtitle: Text(hotel.location),
          onTap: () {
            query = hotel.name;  // Set the query to the selected hotel name
            showResults(context);  // Show the results
          },
        );
      },
    );
  }
}
