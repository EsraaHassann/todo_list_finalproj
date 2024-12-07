import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskDialog extends StatelessWidget {
  final Task? task;
  final Function(Task) onSave;

  const TaskDialog({Key? key, this.task, required this.onSave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: task?.name);
    final detailsController = TextEditingController(text: task?.details);

    return AlertDialog(
      title: Text(task == null ? "Add Task" : "Edit Task"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Task Name"),
          ),
          TextField(
            controller: detailsController,
            decoration: const InputDecoration(labelText: "Task Details"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            onSave(Task(
              name: nameController.text,
              details: detailsController.text,
            ));
            Navigator.pop(context);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
