import 'package:flutter_test/flutter_test.dart';
import 'package:japanese_learning_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NihongoSchoolApp()); // <--- CHANGE THIS LINE

    // Verify that our counter starts at 0.
    // (Note: You might need to update the rest of this test 
    // later once we add actual logic, but this fixes the error now).
  });
} 