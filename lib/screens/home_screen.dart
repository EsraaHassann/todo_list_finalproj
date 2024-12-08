import 'package:flutter/material.dart';
import 'todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5), // Light pink background
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.white, // White text color for contrast
          ),
        ),
        backgroundColor: const Color(0xFFFF69B4), // Hot pink app bar
        elevation: 0, // Flat app bar for a soft look
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFC0CB), // Pastel pink button
            padding: const EdgeInsets.symmetric(
              horizontal: 36,
              vertical: 18,
            ), // Padding for a larger button
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24), // Rounded pill shape
            ),
            elevation: 5, // Slight shadow for a pop-out effect
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ToDoScreen()),
            );
          },
          child: const Text(
            "Go to To-Do List",
            style: TextStyle(
              fontSize: 20, // Slightly larger text size
              color: Colors.white, // White text for contrast
              fontWeight: FontWeight.w600, // Semi-bold for emphasis
              letterSpacing: 1.5, // Slight letter spacing for elegance
            ),
          ),
        ),
      ),
    );
  }
}
