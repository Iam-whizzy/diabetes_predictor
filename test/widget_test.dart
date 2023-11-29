import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diabetes_predictor/main.dart';

void main() {
  testWidgets('Diabetes Predictor Form Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Fill in some data in the form fields.
    await tester.enterText(find.byKey(const Key('children')), '2');
    await tester.enterText(find.byKey(const Key('glucose')), '120');
    // Repeat this for other form fields...

    // Tap the 'Predict' button.
    await tester.tap(find.byType(ElevatedButton));
    //await tester.tap(find.byKey(const Key('predict_button')));

    await tester.pump();

    // Verify that the form data is printed.
    expect(
        find.text('{"children": "2", "glucose": "120", ...}'), findsOneWidget);
  });
}
