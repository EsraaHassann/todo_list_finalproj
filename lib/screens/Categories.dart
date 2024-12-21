// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:todo_list_finalproj/screens/home_screen.dart';
// class Categories extends StatelessWidget {
//   final String title;

//   // Constructor to accept title
//   const Categories({Key? key, required this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Icon(Icons.task_alt, color: const Color.fromARGB(194, 99, 99, 1), size: 24), // Add an icon
//       SizedBox(width: 8), // Space between icon and text
//       Text(
//         title,
//         style: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: const Color.fromRGBO(194, 99, 99, 1),
//         ),
//       ),
//     ],
//   ),
//   centerTitle: true, // Center the title // Use the passed title
//         actions: [
//           IconButton(icon: Icon(Icons.search), onPressed: () {}),
//           IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Category Tabs
//           Container(
//             height: 50,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Chip(label: Text("All Tasks")),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Chip(label: Text("Work")),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Chip(label: Text("Personal")),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Chip(label: Text("Urgent")),
//                 ),
//               ],
//             ),
//           ),
//           // Task List
//           Expanded(
//             child: ListView.builder(
//               itemCount: 10, // Replace with actual task count
//               itemBuilder: (context, index) {
//                 return Card(
//                   color: const Color.fromARGB(255, 214, 119, 231),
//                   margin: EdgeInsets.all(10),
//                   child: ListTile(
//                     title: Text("Task Title $index"),
//                     subtitle: Text("Due: Tomorrow, 10 AM"),
//                     trailing: Icon(Icons.priority_high, color: Colors.red),
//                     onTap: () {
//                       // Navigate to Task Details
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Navigate to Add Task Page
//         },
//         child: Icon(Icons.add),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
//         ],
//         onTap: (index) {
//           // Handle navigation
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:todo_list_finalproj/widgets/task_card.dart';
// import '../models/task_model.dart';

// class Categories extends StatefulWidget {
//   final String title;

//   const Categories({Key? key, required this.title}) : super(key: key);

//   @override
//   _CategoriesState createState() => _CategoriesState();
// }

// class _CategoriesState extends State<Categories> {
//   List<Task> tasks = [];

//   // Fetch tasks from Firestore
//   void fetchTasks() async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('tasks').get();
//       setState(() {
//         tasks = querySnapshot.docs.map((doc) {
//           return Task.fromFirestore(doc.data() as Map<String, dynamic>, doc.id); // Convert Firestore data into Task objects
//         }).toList();
//       });
//     } catch (e) {
//       print("Error fetching tasks: $e");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchTasks();  // Fetch tasks when the widget is initialized
//   }

//   // Task actions
//   void markTask(Task task) {
//     print('Marked task: ${task.title}');
//   }

//   void deleteTask(Task task) async {
//     try {
//       // Delete the task from Firestore
//       await FirebaseFirestore.instance.collection('tasks').doc(task.id).delete();

//       // Remove the task from the local list
//       setState(() {
//         tasks.removeWhere((t) => t.id == task.id);
//       });
//     } catch (e) {
//       print("Error deleting task: $e");
//     }
//   }

//   void editTask(Task task) {
//     print('Edit task: ${task.title}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.task_alt, color: const Color.fromARGB(194, 99, 99, 1), size: 24),
//             SizedBox(width: 8),
//             Text(
//               widget.title,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: const Color.fromRGBO(194, 99, 99, 1),
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(icon: Icon(Icons.search), onPressed: () {}),
//           IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Category Tabs
//           Container(
//             height: 50,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Chip(label: Text("All Tasks")),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Chip(label: Text("Work")),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Chip(label: Text("Personal")),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Chip(label: Text("Urgent")),
//                 ),
//               ],
//             ),
//           ),

//           // Task List (using TaskCard widget)
//           Expanded(
//             child: tasks.isEmpty
//                 ? Center(child: CircularProgressIndicator()) // Show loading spinner if tasks are not yet loaded
//                 : ListView.builder(
//                     itemCount: tasks.length,
//                     itemBuilder: (context, index) {
//                       return TaskCard(
//                         task: tasks[index],
//                         onMark: () => markTask(tasks[index]),
//                         onEdit: (task) => editTask(task),
//                         onDelete: () => deleteTask(tasks[index]),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const ToDoScreen()),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
//         ],
//         onTap: (index) {
//           // Handle navigation
//         },
//       ),
//     );
//   }
// }

