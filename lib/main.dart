import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController childrenController = TextEditingController();
  final TextEditingController glucoseController = TextEditingController();
  final TextEditingController bpController = TextEditingController();
  final TextEditingController stController = TextEditingController();
  final TextEditingController insulinController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();
  final TextEditingController dpfController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  void _submitForm() async {
    final response = await http.post(
      'http://127.0.0.1:5000/' as Uri,
      body: {
        'children': childrenController.text,
        'glucose': glucoseController.text,
        'bp': bpController.text,
        'st': stController.text,
        'insulin': insulinController.text,
        'bmi': bmiController.text,
        'dpf': dpfController.text,
        'age': ageController.text,
      },
    );

    if (response.statusCode == 200) {
      print('Server response: ${response.body}');
      // Handle the response as needed
    } else {
      print('Failed to submit form. Server returned ${response.statusCode}');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes Predictor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Your form fields go here
            TextFormField(
              controller: childrenController,
              decoration: const InputDecoration(labelText: 'children'),
            ),
             TextFormField(
              controller: glucoseController,
              decoration: const InputDecoration(labelText: 'glucose'),
            ),
             TextFormField(
              controller: bpController,
              decoration: const InputDecoration(labelText: 'bp'),
            ),
             TextFormField(
              controller: stController,
              decoration: const InputDecoration(labelText: 'st'),
            ),
             TextFormField(
              controller: insulinController,
              decoration: const InputDecoration(labelText: 'insulin'),
            ),
            TextFormField(
              controller: bmiController,
              decoration: const InputDecoration(labelText: 'bmi'),
            ),
            TextFormField(
              controller: dpfController,
              decoration: const InputDecoration(labelText: 'dpf'),
            ),
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'age'),
            ),
            // Add other TextFormField widgets for other fields

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
