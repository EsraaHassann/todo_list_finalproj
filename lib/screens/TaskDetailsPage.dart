import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskDetailsPage extends StatelessWidget {
  final Task task;

  const TaskDetailsPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Column(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 136, 185, 189),
                      Color.fromARGB(255, 194, 222, 224),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 245, 245, 245),
                ),
              ),
            ],
          ),

          // Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Task Title Card
                  _buildDetailCard(
                    title: "Task Title",
                    icon: Icons.task,
                    content: task.title,
                  ),

                  // Task Date Card
                  _buildDetailCard(
                    title: "Task Date",
                    icon: Icons.calendar_today,
                    content: task.startDate,
                  ),

                  // Description Card
                  _buildDetailCard(
                    title: "Description",
                    icon: Icons.description,
                    content: task.description,
                  ),

                  // Timing Card
                  _buildDetailCard(
                    title: "Timing",
                    icon: Icons.access_time,
                    content:
                        "Start Time: ${task.startTime}\nEnd Time: ${task.endTime}",
                  ),

                  // Status Card
                  _buildDetailCard(
                    title: "Status",
                    icon: task.isCompleted
                        ? Icons.check_circle_outline
                        : Icons.cancel_outlined,
                    content: task.isCompleted ? "Completed" : "Incomplete",
                    iconColor:
                        task.isCompleted ? Colors.green : Colors.redAccent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Navigation
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text("Return to Tasks"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 136, 185, 189),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 5,
            ),
          ),
        ),
      ),
    );
  }

  // Reusable Card Builder for Details
  Widget _buildDetailCard({
    required String title,
    required IconData icon,
    required String content,
    Color iconColor = const Color.fromARGB(255, 136, 185, 189),
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(
          bottom: 8), // Reduced margin to minimize spacing
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30, color: iconColor),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
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
