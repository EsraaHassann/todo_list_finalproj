/*import 'package:flutter/material.dart';
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
}*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Ensure this import is added
import '../models/task_model.dart';

class TaskDialog extends StatefulWidget {
  final Task? task;
  final Function(Task) onSave;

  const TaskDialog({Key? key, this.task, required this.onSave}) : super(key: key);

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    // Initialize the title and description fields with existing task values if any
    if (widget.task != null) {
      title = widget.task!.title;
      description = widget.task!.description;
    } else {
      title = '';
      description = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: title,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              onChanged: (value) => title = value,
            ),
            TextFormField(
              initialValue: description,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
              onChanged: (value) => description = value,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final task = Task(
                title: title,
                description: description,
                createdAt: Timestamp.now(), // Current timestamp
              );
              widget.onSave(task); // Call the onSave function passed from the parent widget
              Navigator.pop(context); // Close the dialog
            }
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context), // Close the dialog without saving
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}


