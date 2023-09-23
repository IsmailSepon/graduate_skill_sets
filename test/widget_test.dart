// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gp/auth/model/university_model.dart';
import 'package:gp/auth/repo/auth_repository.dart';
import 'package:gp/firebase_options.dart';

import 'package:gp/main.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  test('Student Registration', () async {

    University university = const University(name: 'Test University', id: '1234567890');
    AuthRepository repository = AuthRepository();
    bool test = await  repository.registerWithEmailAndPassword('test@gmail.com', '123456789', university, 'Computer Science', '1234567890', '${DateTime.now()}', 'Test User');
    expect(test, true);

    print('Student Registration Test $test');
  });



}

