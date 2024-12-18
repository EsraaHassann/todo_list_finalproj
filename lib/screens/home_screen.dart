import 'package:flutter/material.dart';
import 'package:todo_list_finalproj/screens/todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFC0CB),
              Color(0xFFFF69B4)
            ], // Gradient from light pink to hot pink
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Motivational Sentence Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: const [
                  SizedBox(height: 40), // Spacing from top
                  Text(
                    "Stay Focused, Stay Organized!",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Turn your goals into reality with our To-Do List app.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Icon Section
            const Icon(
              Icons.checklist,
              size: 200,
              color: Colors.white70,
            ),

            // Let's Start Button Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ToDoScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  "Let's Start",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
