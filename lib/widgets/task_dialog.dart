import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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
  late stt.SpeechToText _speech;
  bool _isListening = false;

  String title = '';
  String description = '';
  String? selectedCategory;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();

    if (widget.task != null) {
      title = widget.task!.title;
      description = widget.task!.description;
      _titleController.text = title;
      _descriptionController.text = description;
      _dateController.text = widget.task!.startDate;
      _startTimeController.text = widget.task!.startTime;
      _endTimeController.text = widget.task!.endTime;
    }
  }

 void _listen(TextEditingController controller) async {
  if (!_isListening) {
    bool available = await _speech.initialize(
      onStatus: (status) => print('Speech status: $status'),
      onError: (error) => print('Speech error: $error'),
    );
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          setState(() {
            // Get the recognized words and only append if they are new
            String newWords = result.recognizedWords.trim();
            if (newWords.isNotEmpty && newWords != controller.text.trim()) {
              controller.text = newWords;  // Set the field to the latest recognized words
            }
          });
        },
      );
    } else {
      print('Speech recognition not available.');
    }
  } else {
    setState(() => _isListening = false);
    _speech.stop();
  }
}


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(
                label: 'Task Name',
                controller: _titleController,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                label: 'Task Description',
                controller: _descriptionController,
              ),
              const SizedBox(height: 10),
              _buildDateTimeField(
                label: 'Date',
                controller: _dateController,
                onTap: _pickDate,
              ),
              const SizedBox(height: 10),
              _buildDateTimeField(
                label: 'Start Time',
                controller: _startTimeController,
                onTap: () => _pickTime(_startTimeController),
              ),
              const SizedBox(height: 10),
              _buildDateTimeField(
                label: 'End Time',
                controller: _endTimeController,
                onTap: () => _pickTime(_endTimeController),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final task = Task(
                id: '', // Firestore will auto-generate this
                title: _titleController.text,
                description: _descriptionController.text,
                startDate: _dateController.text,
                startTime: _startTimeController.text,
                endTime: _endTimeController.text,
                createdAt: Timestamp.now(),
              );
              widget.onSave(task);
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: Icon(_isListening ? Icons.mic_off : Icons.mic),
          onPressed: () => _listen(controller),
        ),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Please enter $label' : null,
    );
  }

  Widget _buildDateTimeField({
    required String label,
    required TextEditingController controller,
    required Function() onTap,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      onTap: onTap,
    );
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _pickTime(TextEditingController controller) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }
}
