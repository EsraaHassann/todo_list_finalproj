import 'package:flutter/material.dart';
import 'todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.grey, // Set navbar color to grey
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // White button background
            padding: const EdgeInsets.symmetric(
                horizontal: 32, vertical: 16), // Add padding for larger button
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
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
              fontSize: 18, // Bigger text size
              color: Colors.black, // Black text color
              fontWeight: FontWeight.bold, // Bold text
            ),
          ),
        ),
      ),
    );
  }
}