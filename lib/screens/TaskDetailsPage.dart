import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskDetailsPage extends StatelessWidget {
  final Task task;

  const TaskDetailsPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
        backgroundColor: const Color.fromARGB(255, 136, 185, 189),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Title
            Center(
              child: Text(
                task.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 136, 185, 189),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Task Description
            Card(
              color: const Color.fromARGB(255, 249, 249, 249),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Description:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 136, 185, 189),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      task.description,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Task Date
            Row(
              children: [
                const Icon(Icons.date_range,
                    color: Color.fromARGB(255, 136, 185, 189)),
                const SizedBox(width: 10),
                Text(
                  "Date: ${task.startDate}", // `startDate` is now used as a general `date`
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Start and End Times
            Row(
              children: [
                const Icon(Icons.access_time,
                    color: Color.fromARGB(255, 136, 185, 189)),
                const SizedBox(width: 10),
                Text(
                  "Start Time: ${task.startTime}",
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.access_time,
                    color: Color.fromARGB(255, 136, 185, 189)),
                const SizedBox(width: 10),
                Text(
                  "End Time: ${task.endTime}",
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Task Category
            Row(
              children: [
                const Icon(Icons.category,
                    color: Color.fromARGB(255, 136, 185, 189)),
                const SizedBox(width: 10),
                Text(
                  "Category: ${task.id}", // Replace `task.id` with the category if available
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Status
            Row(
              children: [
                Icon(
                  task.isCompleted
                      ? Icons.check_circle_outline
                      : Icons.cancel_outlined, // Conditional Icon
                  color: task.isCompleted ? Colors.green : Colors.redAccent,
                ),
                const SizedBox(width: 10),
                Text(
                  task.isCompleted ? "Completed" : "Incomplete",
                  style: TextStyle(
                    fontSize: 18,
                    color: task.isCompleted ? Colors.green : Colors.redAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Action Buttons
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 136, 185, 189),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  "Back to Tasks",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
