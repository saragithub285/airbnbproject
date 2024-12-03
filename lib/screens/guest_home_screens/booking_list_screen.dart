import 'package:airbnbmc/paymob/payment_gateway.dart';
import 'package:airbnbmc/paymob/paymob_manager.dart';
import 'package:airbnbmc/widgets/calender_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingListScreen extends StatefulWidget {
  final double hotelPricePerDay; // Receive the hotel price per day

  const BookingListScreen({super.key, required this.hotelPricePerDay});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  List<DateTime> _bookedDates = [];
  List<DateTime> _selectedDates = [];
  List<CalenderUi> calenderWidgets = [];
  bool _isLoading = true;

  Future<void> _fetchBookedDatesFromFirestore() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('bookings').get();
      List<DateTime> fetchedDates = [];
      for (var doc in snapshot.docs) {
        List<dynamic> dates = doc['bookedDates'];
        fetchedDates.addAll(dates.map((date) => (date as Timestamp).toDate()));
      }
      setState(() {
        _bookedDates = fetchedDates;
        _buildCalenderWidgets();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _buildCalenderWidgets() {
    calenderWidgets.clear();
    for (int i = 0; i < 12; i++) {
      calenderWidgets.add(CalenderUi(
        monthIndex: i,
        bookedDates: _bookedDates,
        selectDate: _selectDate,
        getSelectedDate: _getSelectedDates,
      ));
    }
  }

  void _selectDate(DateTime dateTime) {
    if (_selectedDates.contains(dateTime)) {
      _selectedDates.remove(dateTime);
    } else {
      _selectedDates.add(dateTime);
    }
    setState(() {});
  }

  List<DateTime> _getSelectedDates() {
    return _selectedDates;
  }

  double _calculateTotalPrice() {
    int totalSelectedDays = _selectedDates.length;

    return totalSelectedDays * widget.hotelPricePerDay;
  }

  void _continueToPayment(double price) async {
    try {
      // Show a loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Call the Paymob API
      String paymentKey = await PaymobManager().payWithPaymob(price);
      print(paymentKey);

      if (!mounted) return;

      // Navigate to the payment gateway
      Navigator.pop(context); // Close the loading dialog
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentGateway(paymentKey: paymentKey),
        ),
      );
    } catch (e) {
      // Log the error and show an error dialog
      print('Error getting payment key: $e');
      if (!mounted) return;

      Navigator.pop(context); // Close the loading dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Payment Error'),
          content: Text('Failed to initiate payment: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBookedDatesFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Calendar'),
        backgroundColor: Colors.red,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Sun'),
                      Text('Mon'),
                      Text('Tue'),
                      Text('Wed'),
                      Text('Thu'),
                      Text('Fri'),
                      Text('Sat'),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: calenderWidgets.isEmpty
                        ? const Center(child: Text('No calendar available.'))
                        : PageView.builder(
                            itemCount: calenderWidgets.length,
                            itemBuilder: (context, index) {
                              return calenderWidgets[index];
                            },
                          ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Total Price: \$${_calculateTotalPrice().toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _continueToPayment(_calculateTotalPrice());
                    },
                    child: const Text('Proceed to Payment'),
                  ),
                ],
              ),
            ),
    );
  }
}
