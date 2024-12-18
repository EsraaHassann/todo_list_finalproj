import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        backgroundColor: const Color(0xFFFF69B4),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Title
              const Text(
                "Welcome to To-Do App!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
              const SizedBox(height: 20),

              // App Description
              const Text(
                "To-Do App is designed to help you stay organized and focused by tracking your tasks. "
                "It's simple yet powerful, allowing you to manage your daily tasks, mark them as done, and keep track of your progress. "
                "Whether it's a simple to-do list or a project with deadlines, To-Do App is here to help you achieve your goals efficiently.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 30),

              // Feature Cards (without icons)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _FeatureCard(
                    title: 'Task Management',
                    description: 'Track and organize your tasks easily.',
                  ),
                  _FeatureCard(
                    title: 'Time Management',
                    description: 'Set deadlines and monitor progress.',
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Our Mission (instead of "Developed By")
              const Text(
                "Our Mission",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "At To-Do App, we believe that effective task management is the key to productivity and success. "
                "Our goal is to provide a simple yet powerful tool that helps you manage your tasks, set clear goals, and stay organized. "
                "By keeping track of your tasks and focusing on what matters, we aim to help you achieve your best self every day.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 40),

              // Footer Text
              const Center(
                child: Text(
                  "© 2024 To-Do App. All rights reserved.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// A widget for displaying feature cards without icons
class _FeatureCard extends StatelessWidget {
  final String title;
  final String description;

  const _FeatureCard({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF8E1F4),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
