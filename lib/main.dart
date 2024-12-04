import 'package:airbnbmc/provider/tripprovider.dart'; // Import TripsProvider
import 'package:airbnbmc/provider/userprovider.dart';
import 'package:airbnbmc/screens/guesthomescreen.dart';
import 'package:airbnbmc/screens/loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Use MultiProvider to provide both providers
      providers: [
        ChangeNotifierProvider(create: (_) => TripsProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Airbnb',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginScreen(),
      ),
    );
  }
}

class AppInit extends StatefulWidget {
  const AppInit({super.key});
  
  @override
  _AppInitState createState() => _AppInitState();
}

class _AppInitState extends State<AppInit> {
  @override
  void initState() {
    super.initState();
    // Initialize UserProvider to check if a user is logged in
    Provider.of<UserProvider>(context, listen: false).initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        // If user is logged in, navigate to HomeScreen, otherwise LoginScreen
        if (userProvider.isLoggedIn) {
          // User is logged in, navigate to HomeScreen
          return GuestHomeScreen();
        } else {
          // User is not logged in, navigate to LoginScreen
          return const LoginScreen();
        }
      },
    );
  }
}
