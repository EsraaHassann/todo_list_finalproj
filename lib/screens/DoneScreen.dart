import 'package:flutter/material.dart';
import 'package:todo_list_finalproj/screens/ToDoScreen.dart';
import 'package:todo_list_finalproj/screens/home_screen.dart';
import '../models/task_model.dart';
import '../widgets/task_card.dart';
import '../widgets/task_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  _DoneScreenState createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {

  void addTask(Task task) async {
    await FirebaseFirestore.instance.collection('tasks').add({
      'title': task.title,
      'description': task.description,
      'isCompleted': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  void editTask(Task oldTask, Task newTask) async {
    final taskDoc = await FirebaseFirestore.instance
        .collection('tasks')
        .where('title', isEqualTo: oldTask.title)
        .get();

    if (taskDoc.docs.isNotEmpty) {
      taskDoc.docs.first.reference.update({
        'title': newTask.title,
        'description': newTask.description,
      });
    }
  }

  void deleteTask(Task task) async {
    final taskDoc = await FirebaseFirestore.instance
        .collection('tasks')
        .where('title', isEqualTo: task.title)
        .get();

    if (taskDoc.docs.isNotEmpty) {
      taskDoc.docs.first.reference.delete();
    }
  }

  void markTask(Task task) async {
    final taskDoc = await FirebaseFirestore.instance
        .collection('tasks')
        .where('title', isEqualTo: task.title)
        .get();

    if (taskDoc.docs.isNotEmpty) {
      taskDoc.docs.first.reference.update({
        'isCompleted': !task.isCompleted, // Toggle completion status
      });

      // Refresh the task lists after marking as completed
      setState(() {});
    }
  }

  void _showTaskDialog({Task? task}) {
    showDialog(
      context: context,
      builder: (context) {
        return TaskDialog(
          task: task,
          onSave: (newTask) {
            if (task != null) {
              editTask(task, newTask); // Edit task
            } else {
              addTask(newTask); // Add new task
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Done", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFFF69B4),
        elevation: 0,
      ), drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Color(0xFFFF69B4),
        ),
        child: Text(
          'To-Do App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text('Home'),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.list),
        title: const Text('To-Do List'),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ToDoScreen()),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.check_circle),
        title: const Text('Completed Tasks'),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DoneScreen()), // Navigate to DoneScreen
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('Settings'),
        onTap: () {
          Navigator.pop(context); // Close the drawer
          // Navigate to settings or other pages
        },
      ),
      ListTile(
        leading: const Icon(Icons.info),
        title: const Text('About'),
        onTap: () {
          Navigator.pop(context); // Close the drawer
          // Navigate to About page if needed
        },
      ),
    ],
  ),
),
      backgroundColor: const Color(0xFFFFF0F5),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          }

          final tasks = snapshot.data?.docs
                  .map((doc) => Task.fromFirestore(
                      doc.data() as Map<String, dynamic>, doc.id))
                  .toList() ??
              [];

          // Filter tasks that are completed
          final filteredTasks = tasks.where((task) => task.isCompleted).toList();

          return ListView.builder(
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              final task = filteredTasks[index];
              return TaskCard(
                task: task,
                onMark: () => markTask(task), // Mark task as done or undone
                onEdit: (task) => _showTaskDialog(task: task), // Edit task
                onDelete: () => deleteTask(task), // Delete task
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(),
        backgroundColor: const Color(0xFFFF69B4),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
