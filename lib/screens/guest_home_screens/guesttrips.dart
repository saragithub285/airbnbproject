import 'package:airbnbmc/models/hoteldata.dart'; // Import the Hotel model
import 'package:airbnbmc/provider/tripprovider.dart'; // Import the TripsProvider
import 'package:airbnbmc/screens/guest_home_screens/booking_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  _TripsScreenState createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  // Function to calculate the total price of all trips
  double getTotalPrice(List<Hotel> trips) {
    return trips.fold(0.0, (total, hotel) => total + hotel.price);
  }

  @override
  Widget build(BuildContext context) {
    // Get the trips from the TripsProvider
    var trips = Provider.of<TripsProvider>(context).trips;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Trips'),
      ),
      body: trips.isEmpty
          ? const Center(child: Text('No trips added yet'))
          : Column(
              children: [
                // Display the list of trips
                Expanded(
                  child: ListView.builder(
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      var hotel = trips[index];
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
                                  image: NetworkImage(hotel.images.isNotEmpty
                                      ? hotel.images[0]
                                      : ''),
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
                ),
                // Display the total price and checkout button
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        'Total: \$${getTotalPrice(trips).toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Handle checkout (mock payment for now)
                          _handleCheckout(context, trips);
                        },
                        child: const Text('Proceed to Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // Handle checkout (mock payment for now)
  void _handleCheckout(BuildContext context, List<Hotel> trips) {
    double totalPrice = getTotalPrice(trips);

    // Here, you would typically integrate a payment gateway like Stripe or PayPal.
    // For now, let's just show a success message with the total price.

    //go to calender screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingListScreen(hotelPricePerDay: totalPrice),
      ),
    );
  }
}
