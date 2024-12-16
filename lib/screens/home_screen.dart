// import 'package:flutter/material.dart';
// import 'package:todo_list_finalproj/screens/todo_screen.dart';
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFF0F5), // Light pink background
//       appBar: AppBar(
//         title: const Text(
//           "Home",
//           style: TextStyle(
//             color: Colors.white, // White text color for contrast
//           ),
//         ),
//         backgroundColor: const Color(0xFFFF69B4), // Hot pink app bar
//         elevation: 0, // Flat app bar for a soft look
//       ),
//       body: Center(
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFFFFC0CB), // Pastel pink button
//             padding: const EdgeInsets.symmetric(
//               horizontal: 36,
//               vertical: 18,
//             ), // Padding for a larger button
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(24), // Rounded pill shape
//             ),
//             elevation: 5, // Slight shadow for a pop-out effect
//           ),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const ToDoScreen()),
//             );
//           },
//           child: const Text(
//             "Go to To-Do List",
//             style: TextStyle(
//               fontSize: 20, // Slightly larger text size
//               color: Colors.white, // White text for contrast
//               fontWeight: FontWeight.w600, // Semi-bold for emphasis
//               letterSpacing: 1.5, // Slight letter spacing for elegance
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:todo_list_finalproj/screens/todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
         backgroundColor: const Color(0xFFFF69B4), // Hot pink app bar
       elevation: 0,
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
