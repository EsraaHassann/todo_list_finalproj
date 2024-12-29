import 'package:flutter/material.dart';
import 'package:todo_list_finalproj/widgets/drawer_widget.dart'; // Import the DrawerWidget

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Variables to control the settings options
  bool _isDarkMode = false;
  bool _isNotificationsEnabled = true;
  String _selectedLanguage = 'English';

  // List of available languages
  final List<String> _languages = ['English', 'Spanish', 'French', 'German'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color.fromARGB(255, 136, 185, 189),
      ),
      drawer: DrawerWidget(), // Add the drawer here
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Dark Mode Toggle
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),

            // Notifications Toggle
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: _isNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _isNotificationsEnabled = value;
                });
              },
            ),

            // Language Selection
            ListTile(
              title: const Text('Language'),
              subtitle: Text(_selectedLanguage),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () async {
                String? selected = await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Select Language'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: _languages
                              .map((language) => RadioListTile<String>(
                                    title: Text(language),
                                    value: language,
                                    groupValue: _selectedLanguage,
                                    onChanged: (value) {
                                      Navigator.pop(context, value);
                                    },
                                  ))
                              .toList(),
                        ),
                      ),
                    );
                  },
                );
                if (selected != null) {
                  setState(() {
                    _selectedLanguage = selected;
                  });
                }
              },
            ),

            // Reset Settings Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isDarkMode = false;
                  _isNotificationsEnabled = true;
                  _selectedLanguage = 'English';
                });
              },
              style: ElevatedButton.styleFrom(iconColor: Colors.red),
              child: const Text('Reset Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
