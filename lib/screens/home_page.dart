import 'package:flutter/material.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Today's Overview",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFFF69B4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Today's Progress Summary
            const Text(
              "Today's Progress Summary",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tasks Completed: 3/5",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Focus Time: 4 hours",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Breaks Taken: 2",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Today's Tasks
            const Text(
              "Today's Tasks",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.check_box_outline_blank,
                        color: Colors.pinkAccent),
                    title: Text("Task 1: Complete Flutter UI"),
                    subtitle: Text("Deadline: 5:00 PM"),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.check_box, color: Colors.pinkAccent),
                    title: Text("Task 2: Team Meeting"),
                    subtitle: Text("Completed"),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_box_outline_blank,
                        color: Colors.pinkAccent),
                    title: Text("Task 3: Review PRs"),
                    subtitle: Text("Deadline: 7:00 PM"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
