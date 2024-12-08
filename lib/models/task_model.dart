/*class Task {
  final String name;
  final String details;
  bool isDone;

  Task({required this.name, required this.details, this.isDone = false});
}*/
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore dependencies

class Task {
  final String title;
  final String description;
  final bool isCompleted;
  final Timestamp createdAt;

  Task({
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.createdAt,
  });

  // Factory constructor for creating Task from Firestore data
  factory Task.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>; // Convert doc data to a Map
    return Task(
      title: data['title'] ?? '', // Ensure data exists and provide fallback if needed
      description: data['description'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      createdAt: data['createdAt'] as Timestamp, // Ensure correct type casting to Timestamp
    );
  }

  // Convert Task to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt,
    };
  }
}
