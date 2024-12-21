// import 'package:flutter/material.dart';
// import '../models/task_model.dart';
// import '../widgets/task_card.dart';
// import '../widgets/task_dialog.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ToDoScreen extends StatefulWidget {
//   const ToDoScreen({Key? key}) : super(key: key);

//   @override
//   _ToDoScreenState createState() => _ToDoScreenState();
// }

// class _ToDoScreenState extends State<ToDoScreen> {
//   int selectedTab = 0;

//   void addTask(Task task) async {
//     await FirebaseFirestore.instance.collection('tasks').add({
//       'title': task.title,
//       'description': task.description,
//       'isCompleted': false,
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//   }

//   void editTask(Task oldTask, Task newTask) async {
//     final taskDoc = await FirebaseFirestore.instance
//         .collection('tasks')
//         .where('title', isEqualTo: oldTask.title)
//         .get();

//     if (taskDoc.docs.isNotEmpty) {
//       taskDoc.docs.first.reference.update({
//         'title': newTask.title,
//         'description': newTask.description,
//       });
//     }
//   }

//   void deleteTask(Task task) async {
//     final taskDoc = await FirebaseFirestore.instance
//         .collection('tasks')
//         .where('title', isEqualTo: task.title)
//         .get();

//     if (taskDoc.docs.isNotEmpty) {
//       taskDoc.docs.first.reference.delete();
//     }
//   }

//   void markTask(Task task) async {
//     final taskDoc = await FirebaseFirestore.instance
//         .collection('tasks')
//         .where('title', isEqualTo: task.title)
//         .get();

//     if (taskDoc.docs.isNotEmpty) {
//       taskDoc.docs.first.reference.update({
//         'isCompleted': !task.isCompleted, // Toggle completion status
//       });

//       // Refresh the task lists after marking as completed
//       setState(() {});
//     }
//   }

//   void _showTaskDialog({Task? task}) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return TaskDialog(
//           task: task,
//           onSave: (newTask) {
//             if (task != null) {
//               editTask(task, newTask); // Edit task
//             } else {
//               addTask(newTask); // Add new task
//             }
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("To-Do", style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFFFF69B4),
//         elevation: 0,
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Color(0xFFFF69B4),
//               ),
//               child: Text(
//                 'To-Do App',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: const Text('Home'),
//               onTap: () {
//                 Navigator.pop(context); // Close the drawer
//                 Navigator.pop(context); // Go back to HomeScreen
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.list),
//               title: const Text('To-Do List'),
//               onTap: () {
//                 Navigator.pop(context); // Close the drawer
//                 // Stay on the To-Do screen
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings),
//               title: const Text('Settings'),
//               onTap: () {
//                 Navigator.pop(context); // Close the drawer
//                 // Navigate to settings or other pages
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.info),
//               title: const Text('About'),
//               onTap: () {
//                 Navigator.pop(context); // Close the drawer
//                 // Navigate to About page if needed
//               },
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: const Color(0xFFFFF0F5),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               _buildTabButton("To-Do", 0, const Color(0xFFFFB6C1)),
//               _buildTabButton("Done", 1, const Color(0xFFDB7093)),
//             ],
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               color: const Color(0xFFFFF0F5),
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('tasks')
//                     .orderBy('createdAt', descending: true)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (snapshot.hasError) {
//                     return const Center(child: Text('Something went wrong!'));
//                   }

//                   final tasks = snapshot.data?.docs
//                           .map((doc) => Task.fromFirestore(
//                               doc.data() as Map<String, dynamic>, doc.id))
//                           .toList() ??
//                       [];

//                   // Filter tasks based on selected tab
//                   final filteredTasks = tasks.where((task) {
//                     if (selectedTab == 0) {
//                       return !task
//                           .isCompleted; // To-Do: Tasks that are not completed
//                     } else {
//                       return task.isCompleted; // Done: Tasks that are completed
//                     }
//                   }).toList();

//                   return ListView.builder(
//                     itemCount: filteredTasks.length,
//                     itemBuilder: (context, index) {
//                       final task = filteredTasks[index];
//                       return TaskCard(
//                         task: task,
//                         onMark: () =>
//                             markTask(task), // Mark task as done or undone
//                         onEdit: (task) =>
//                             _showTaskDialog(task: task), // Edit task
//                         onDelete: () => deleteTask(task), // Delete task
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showTaskDialog(),
//         backgroundColor: const Color(0xFFFF69B4),
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }

//   Widget _buildTabButton(String title, int tabIndex, Color backgroundColor) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             selectedTab = tabIndex;
//           });
//         },
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           decoration: BoxDecoration(
//             color: selectedTab == tabIndex
//                 ? backgroundColor
//                 : const Color(0xFFFFC0CB),
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 4,
//                 offset: const Offset(2, 2),
//               ),
//             ],
//           ),
//           child: Text(
//             title,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: selectedTab == tabIndex ? Colors.white : Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
