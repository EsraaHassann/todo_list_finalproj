import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final Timestamp createdAt;
  final String startDate;
  final String startTime;
  final String endTime;
  final String deadline; 
  
  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.createdAt,
    required this.startDate,
    required this.startTime,
    required this.endTime,
    required this.deadline, 
  });

  factory Task.fromFirestore(Map<String, dynamic> data, String id) {
    return Task(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      createdAt: data['createdAt'] as Timestamp,
      startDate: data['startDate'] ?? '',
      startTime: data['startTime'] ?? '',
      endTime: data['endTime'] ?? '',
      deadline: data['deadline'] ?? '', 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt,
      'startDate': startDate,
      'startTime': startTime,
      'endTime': endTime,
      'deadline': deadline, 
    };
  }
}

  


