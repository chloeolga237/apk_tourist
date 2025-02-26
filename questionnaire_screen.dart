// screens/questionnaire_screen.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'firstpage_screen.dart'; // Import the FirstPageScreen file

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  String? selectedOption;

  void _showCookieConsentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Accept Cookies'),
        content: Text('We use cookies to enhance your experience. Do you accept?'),
        actions: [
          TextButton(
            onPressed: () {
              // Logic to handle cookie rejection
              Navigator.of(context).pop();
            },
            child: Text('Decline'),
          ),
          TextButton(
            onPressed: () {
              // Logic to handle cookie acceptance
              Navigator.of(context).pop();
              // You can also save consent here if necessary
            },
            child: Text('Accept'),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Logic to submit the data
      if (kDebugMode) {
        print('Name: ${nameController.text}');
        print('City: ${cityController.text}');
        print('Selected option: $selectedOption');
      }

      // Navigation to FirstPageScreen
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => FirstPageScreen()),
      ).then((_) {
        // Show the cookie consent dialog after navigation
        _showCookieConsentDialog();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Questionnaire')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'What should we call you?',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                  labelText: 'Where do you live? (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedOption,
                decoration: InputDecoration(
                  labelText: 'Choose an option',
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
                  DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
                  DropdownMenuItem(value: 'Option 3', child: Text('Option 3')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please choose an option.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}