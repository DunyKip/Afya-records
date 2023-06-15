import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wecareapplication_parthkhushboo/login_page.dart';
void main() {
Widget myScreen = MediaQuery(
data: const MediaQueryData(), child: MaterialApp(home: LoginPage()));

testWidgets('Testing widgets', (WidgetTester widgettest) async {
  await widgettest.pumpWidget(myScreen);
  expect(find.byType(ElevatedButton),
  findsWidgets);
});
}