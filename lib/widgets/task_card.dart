/*import 'package:flutter/material.dart';
import '../models/task_model.dart';


class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onMark;
  final VoidCallback onDelete;
  final Function(Task) onEdit;

  const TaskCard({
    Key? key,
    required this.task,
    required this.onMark,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        title: Text(task.name),
        subtitle: Text(task.details),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: onMark,
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.yellow),
              onPressed: () => onEdit(task),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onMark;
  final Function(Task) onEdit;
  final VoidCallback onDelete;

  const TaskCard({
    Key? key,
    required this.task,
    required this.onMark,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(task.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => onEdit(task), // Trigger onEdit when the icon is pressed
            ),
            IconButton(
              icon: Icon(task.isCompleted ? Icons.undo : Icons.check),
              onPressed: onMark, // Mark the task as completed or revert
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete, // Delete the task
            ),
          ],
        ),
      ),
    );
  }
}
