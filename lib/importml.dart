import 'package:tflite/tflite.dart';

void loadModel() async {
  await Tflite.loadModel(
    model: 'assets/diabetes_model.tflite',
    labels: 'assets/diabetes_labels.txt',
  );
}

void runPrediction(List<double> inputData) async {
  var output = await Tflite.runModelOnFloatTensor(
    inputTensor: inputData,
  );
  // Handle the output (prediction)
}
