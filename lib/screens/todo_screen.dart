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
      backgroundColor: Colors.grey[100], // Light gray background like Home Page
      appBar: AppBar(
        title: const Text("To-Do"),
        backgroundColor: Colors.grey, // Consistent navbar like Home
      ),
      body: Column(
        children: [
          Row(
            children: [
              _buildTabButton(
                  "To-Do", 0, const Color.fromARGB(255, 215, 211, 211)),
              _buildTabButton("Done", 1, Colors.green),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey[100], // Match the same design aesthetics
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
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
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
                : Colors.grey[300], // Active tab vs inactive tabs
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selectedTab == tabIndex ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16, // Slightly bigger text
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