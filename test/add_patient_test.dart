import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wecareapplication_parthkhushboo/add_patient_screen.dart';


void main() {
 

Widget addpatientform = MediaQuery(
      data: const MediaQueryData(), child: MaterialApp(home: addPatientScreen()));
  
    testWidgets('displays and submits form', (WidgetTester tester) async {
      // Build our widget and trigger a frame.
      await tester.pumpWidget(addpatientform);
        

      // Verify that the form fields are displayed.
      expect(find.text('User Name'), findsOneWidget);

    });
  }
