import 'package:flutter/material.dart';
import 'package:airbnbmc/models/hoteldata.dart'; // Import the Hotel model
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // For the image slider

class HotelDetailPage extends StatefulWidget {
  final Hotel hotel;

  const HotelDetailPage({Key? key, required this.hotel}) : super(key: key);

  @override
  _HotelDetailPageState createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final hotel = widget.hotel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hotel Name
              Text(
                hotel.name,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Image Slider
              SizedBox(
                height: 250,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: hotel.images.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      hotel.images[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),

              // Smooth Page Indicator (for image slider)
              Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: hotel.images.length,
                  effect: ExpandingDotsEffect(
                    dotWidth: 8,
                    dotHeight: 8,
                    spacing: 4,
                    radius: 4,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.deepPurple,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Description
              Text(
                'Description',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                hotel.description,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 24),

              // Location
              Text(
                'Location',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                hotel.location, // Just display location without URL
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 24),

              // Rating
              Text(
                'Rating',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // Display rating as stars
                  for (int i = 0; i < 5; i++)
                    Icon(
                      i < hotel.rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                  SizedBox(width: 8),
                  // Display rating as a numeric value
                  Text(
                    '${hotel.rating.toStringAsFixed(1)} / 5.0',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Price
              Text(
                'Price',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${hotel.price}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
