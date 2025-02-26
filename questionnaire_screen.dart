// screens/questionnaire_screen.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'firstpage_screen.dart'; // Importez le fichier FirstPageScreen

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
              // Logique pour gérer le refus des cookies
              Navigator.of(context).pop();
            },
            child: Text('Decline'),
          ),
          TextButton(
            onPressed: () {
              // Logique pour gérer l'acceptation des cookies
              Navigator.of(context).pop();
              // Vous pouvez aussi enregistrer le consentement ici si nécessaire
            },
            child: Text('Accept'),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Logique pour soumettre les données
      if (kDebugMode) {
        print('Nom: ${nameController.text}');
        print('Ville: ${cityController.text}');
        print('Option choisie: $selectedOption');
      }

      // Navigation vers FirstPageScreen
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => FirstPageScreen()),
      ).then((_) {
        // Afficher le pop-up d'acceptation des cookies après la navigation
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
                  labelText: 'Comment devrions-nous vous appeler ?',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                  labelText: 'Où habitez-vous ? (Optionnel)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedOption,
                decoration: InputDecoration(
                  labelText: 'Choisissez une option',
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
                    return 'Veuillez choisir une option.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Soumettre'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}