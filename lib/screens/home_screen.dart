import 'package:flutter/material.dart';
import 'package:todo_list_finalproj/screens/todo_screen.dart';
import 'package:todo_list_finalproj/screens/Categories.dart';
import 'package:todo_list_finalproj/screens/AddTask.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add Task Button
            ElevatedButton(
              onPressed: () {
               Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ToDoScreen()),
           );
                print('Add Task button pressed');
              },
              child: const Text("Add Task"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20), // Space between buttons

            // Go to Categories Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Categories(title: "Categories"),
                  ),
                );
              },
              child: const Text("Go to Categories Page"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
