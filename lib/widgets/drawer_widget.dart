import 'package:flutter/material.dart';
import 'package:todo_list_finalproj/screens/DoneScreen.dart';
import 'package:todo_list_finalproj/screens/home_screen.dart';
import 'package:todo_list_finalproj/screens/ToDoScreen.dart'; // Add import for ToDoScreen
import 'package:todo_list_finalproj/screens/TodaysTasksScreen.dart'; // Import TodaysTasksScreen

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFFF69B4),
            ),
            child: Text(
              'To-Do App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('To-Do List'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ToDoScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.check_circle),
            title: const Text('Completed Tasks'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DoneScreen()),
              );
            },
          ),
          // Add "Today's Progress" here
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text("Today's Progress"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const TodaysTasksScreen()), // Navigate to TodaysTasksScreen
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Navigate to settings or other pages if necessary
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Navigate to About page if needed
            },
          ),
        ],
      ),
    );
  }
}
