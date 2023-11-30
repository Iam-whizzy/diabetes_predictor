import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      title: 'Diabetes Predictor',
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? _children; // Use int? to allow for null
  int? _glucose;
  int? _bloodpressure;
  int? _skinthickness;
  int? _insulin;
  int? _bmi;
  int? _diabetespedigreefn;
  int? _age;

  String predictionResult = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Children: $_children');
      print('Glucose: $_glucose');
      print('Blood Pressure: $_bloodpressure');
      print('Skin Thickness: $_skinthickness');
      print('Insulin: $_insulin');
      print('BMI: $_bmi');
      print('Diabetes Pedigree Function: $_diabetespedigreefn');
      print('Age: $_age');

      // Call the makePrediction function with the collected data
      makePrediction();
    }
  }@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check now!'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Children',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter number of children.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _children = int.tryParse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Glucose'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter glucose level.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _glucose = int.tryParse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Blood Pressure'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter blood pressure.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _bloodpressure = int.tryParse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Skin Thickness'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Skinthickness.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _skinthickness = int.tryParse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'BMI'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter BMI.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _bmi = int.tryParse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Insulin'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Insulin.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _insulin = int.tryParse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Diabetes Pedigree Function',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter diabetes Pedigree Function';
                  }
                  return null;
                },
                onSaved: (value) {
                  _diabetespedigreefn = int.tryParse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Age';
                  }
                  return null;
                },
                onSaved: (value) {
                  _age = int.tryParse(value!);
                },
              ),
              const SizedBox(height: 20.0),
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

  Future<void> makePrediction() async {
    // Prepare the features list
    List<double> features = [
      _children!.toDouble(),
      _glucose!.toDouble(),
      _bloodpressure!.toDouble(),
      _skinthickness!.toDouble(),
      _insulin!.toDouble(),
      _bmi!.toDouble(),
      _diabetespedigreefn!.toDouble(),
      _age!.toDouble(),
    ];

    // Make a POST request to the server with the features
    final response = await http.post(
      Uri.parse('YOUR_SERVER_ENDPOINT'), // Replace with your server endpoint
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'features': features}),
    );

    // Parse the response
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        predictionResult = 'Prediction: ${data['prediction']}';
      });
      // Display the prediction result in a dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Prediction Result'),
            content: Text(predictionResult),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        predictionResult = 'Error';
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}