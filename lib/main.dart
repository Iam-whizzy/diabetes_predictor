import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diabetes Predictor'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'children',
                decoration: InputDecoration(labelText: 'Children'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.numeric(context),
              ),
              FormBuilderTextField(
                name: 'glucose',
                decoration: InputDecoration(labelText: 'Glucose'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.numeric(context),
              ),
              FormBuilderTextField(
                name: 'bloodPressure',
                decoration: InputDecoration(labelText: 'Blood Pressure'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.numeric(context),
              ),
              FormBuilderTextField(
                name: 'skinThickness',
                decoration: InputDecoration(labelText: 'Skin Thickness'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.numeric(context),
              ),
              FormBuilderTextField(
                name: 'insulin',
                decoration: InputDecoration(labelText: 'Insulin'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.numeric(context),
              ),
              FormBuilderTextField(
                name: 'bmi',
                decoration: InputDecoration(labelText: 'BMI'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.numeric(context),
              ),
              FormBuilderTextField(
                name: 'diabetesPedigreeFunction',
                decoration:
                    InputDecoration(labelText: 'Diabetes Pedigree Function'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.numeric(context),
              ),
              FormBuilderTextField(
                name: 'age',
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.numeric(context),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    // Access the form data
                    Map<String, dynamic> formData =
                        _formKey.currentState!.value;
                    // Use the form data as needed, e.g., pass it to your ML model
                    print(formData);
                  }
                },
                child: Text('Predict'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
