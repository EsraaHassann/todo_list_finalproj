import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../widgets/task_card.dart';
import '../widgets/task_dialog.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final List<Task> pendingTasks = [];
  final List<Task> completedTasks = [];
  int selectedTab = 0;

  void addTask(Task task) {
    setState(() {
      pendingTasks.add(task);
    });
  }

  void editTask(Task oldTask, Task newTask) {
    setState(() {
      if (selectedTab == 0) {
        final index = pendingTasks.indexOf(oldTask);
        pendingTasks[index] = newTask;
      } else {
        final index = completedTasks.indexOf(oldTask);
        completedTasks[index] = newTask;
      }
    });
  }

  void deleteTask(Task task) {
    setState(() {
      if (selectedTab == 0) {
        pendingTasks.remove(task);
      } else {
        completedTasks.remove(task);
      }
    });
  }

  void markTask(Task task) {
    setState(() {
      pendingTasks.remove(task);
      completedTasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5), // Light pink background
      appBar: AppBar(
        title: const Text(
          "To-Do",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFFF69B4), // Hot pink AppBar
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            children: [
              _buildTabButton("To-Do", 0, const Color(0xFFFFB6C1)), // Pastel pink
              _buildTabButton("Done", 1, const Color(0xFFDB7093)), // Rosy pink
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: const Color(0xFFFFF0F5), // Match pink background
              child: ListView.builder(
                itemCount: selectedTab == 0
                    ? pendingTasks.length
                    : completedTasks.length,
                itemBuilder: (context, index) {
                  final task = selectedTab == 0
                      ? pendingTasks[index]
                      : completedTasks[index];
                  return TaskCard(
                    task: task,
                    onMark: () => markTask(task),
                    onEdit: (newTask) => editTask(task, newTask),
                    onDelete: () => deleteTask(task),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(),
        backgroundColor: const Color(0xFFFF69B4), // Hot pink
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTabButton(String title, int tabIndex, Color backgroundColor) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = tabIndex;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selectedTab == tabIndex
                ? backgroundColor
                : const Color(0xFFFFC0CB), // Inactive tabs in light pink
            borderRadius: BorderRadius.circular(20), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selectedTab == tabIndex ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  void _showTaskDialog({Task? task}) {
    showDialog(
      context: context,
      builder: (context) {
        return TaskDialog(
          task: task,
          onSave: (newTask) {
            if (task != null) {
              editTask(task, newTask);
            } else {
              addTask(newTask);
            }
          },
        );
      },
    );
  }
}
