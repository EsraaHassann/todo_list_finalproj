import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart'; // To pick audio files

import '../models/task_model.dart';

class TaskDetailsPage extends StatefulWidget {
  final Task task;

  const TaskDetailsPage({super.key, required this.task});

  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  String transcribedText = "Press the microphone to speak...";
  bool isLoading = false;

  // Whisper API Integration
  Future<void> transcribeSpeech(File audioFile) async {
    const String apiUrl = "https://api.openai.com/v1/audio/transcriptions";
    const String apiKey = "YOUR_API_KEY"; // Replace with your Whisper API key

    setState(() {
      isLoading = true;
    });

    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.headers.addAll({
        'Authorization': 'Bearer $apiKey',
      });

      // Add audio file
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        audioFile.path,
      ));

      // Add any required parameters (e.g., language model)
      request.fields['model'] = 'whisper-1'; // Replace with the appropriate model name

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final responseData = jsonDecode(responseBody);

        setState(() {
          transcribedText = responseData['text'] ?? "No transcription found.";
        });
      } else {
        setState(() {
          transcribedText =
              "Error: ${response.statusCode} - ${response.reasonPhrase}";
        });
      }
    } catch (e) {
      setState(() {
        transcribedText = "Error: Unable to connect to the API.";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      File audioFile = File(result.files.single.path!);
      await transcribeSpeech(audioFile);
    } else {
      setState(() {
        transcribedText = "No audio file selected.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Task Details", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 136, 185, 189),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background
          Column(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 136, 185, 189),
                      Color.fromARGB(255, 194, 222, 224),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 245, 245, 245),
                ),
              ),
            ],
          ),

          // Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Task Title Card
                  _buildDetailCard(
                    title: "Task Title",
                    icon: Icons.task,
                    content: widget.task.title,
                  ),

                  // Task Date Card
                  _buildDetailCard(
                    title: "Task Date",
                    icon: Icons.calendar_today,
                    content: widget.task.startDate,
                  ),

                  // Description Card
                  _buildDetailCard(
                    title: "Description",
                    icon: Icons.description,
                    content: widget.task.description,
                  ),

                  // Timing Card
                  _buildDetailCard(
                    title: "Timing",
                    icon: Icons.access_time,
                    content:
                        "Start Time: ${widget.task.startTime}\nEnd Time: ${widget.task.endTime}",
                  ),

                  // Status Card
                  _buildDetailCard(
                    title: "Status",
                    icon: widget.task.isCompleted
                        ? Icons.check_circle_outline
                        : Icons.cancel_outlined,
                    content:
                        widget.task.isCompleted ? "Completed" : "Incomplete",
                    iconColor: widget.task.isCompleted
                        ? Colors.green
                        : Colors.redAccent,
                  ),

                  // Speech-to-Text Section
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(top: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  transcribedText,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: pickAudioFile,
                            icon: const Icon(Icons.mic, color: Colors.white),
                            label: const Text(
                              "Upload Audio",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255, 136, 185, 189),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Card Builder for Details
  Widget _buildDetailCard({
    required String title,
    required IconData icon,
    required String content,
    Color iconColor = const Color.fromARGB(255, 136, 185, 189),
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30, color: iconColor),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
