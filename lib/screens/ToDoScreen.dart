import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';
import '../widgets/task_card.dart';
import '../widgets/task_dialog.dart';
import '../widgets/drawer_widget.dart'; 

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  void addTask(Task task) async {
    await FirebaseFirestore.instance.collection('tasks').add({
      'title': task.title,
      'description': task.description,
      'isCompleted': false,
      'startDate': task.startDate,
      'startTime': task.startTime,
      'endTime': task.endTime,
      'createdAt': FieldValue.serverTimestamp(),  
    });

    setState(() {});
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
        'isCompleted': !task.isCompleted, 
      });

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
              editTask(task, newTask); 
            } else {
              addTask(newTask); 
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
        title: const Text("To-Do", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 136, 185, 189),
        elevation: 0,
      ),
      drawer: DrawerWidget(), 
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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

          final filteredTasks =
              tasks.where((task) => !task.isCompleted).toList();

          return ListView.builder(
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              final task = filteredTasks[index];
              return TaskCard(
                task: task,
                onMark: () => markTask(task), 
                onEdit: (task) => _showTaskDialog(task: task), 
                onDelete: () => deleteTask(task), 
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(), 
        backgroundColor: Color.fromARGB(255, 136, 185, 189),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
