import 'package:airbnbmc/provider/tripprovider.dart'; // Import TripsProvider
import 'package:airbnbmc/screens/guesthomescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart'; // Import provider package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TripsProvider(), // Add the provider to manage trips data
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Airbnb',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: GuestHomeScreen(),
      ),
    );
  }
}
