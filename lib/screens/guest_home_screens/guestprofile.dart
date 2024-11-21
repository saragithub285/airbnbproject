import 'package:flutter/material.dart';
import 'package:get/get.dart';
class GuestProfile extends StatefulWidget {
  const GuestProfile({super.key});

  @override
  State<GuestProfile> createState() => _GuestProfileState();
}

class _GuestProfileState extends State<GuestProfile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('profile Page', style: TextStyle(fontSize: 24)),
    );
  }
}
