import 'package:flutter/material.dart';
import 'package:get/get.dart';
class GuestExplorer extends StatefulWidget {
  const GuestExplorer({super.key});

  @override
  State<GuestExplorer> createState() => _GuestExplorerState();
}

class _GuestExplorerState extends State<GuestExplorer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Explore Page', style: TextStyle(fontSize: 24)),
    );
  }
}
