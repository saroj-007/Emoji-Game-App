import 'package:flutter/material.dart';

class RealLoginScreen extends StatefulWidget {
  const RealLoginScreen({super.key});

  @override
  State<RealLoginScreen> createState() => _RealLoginScreenState();
}

class _RealLoginScreenState extends State<RealLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF3AEF5),
                 // Color(),
                 // Color(),
                 // Color(),
                ])
            ),
          )
        ],
      ),
    );
  }
}