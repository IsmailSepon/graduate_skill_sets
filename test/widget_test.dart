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
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());


  test('Student Registration', () async {
    // Initialize Firebase
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    // Create a mock University object
    University university = University(name: 'Test University', id: '1234567890');

    // Create an instance of your AuthRepository
    AuthRepository repository = AuthRepository(); // Replace with your actual repository

    // Perform the registration test
    bool test = await repository.registerWithEmailAndPassword(
      'test@gmail.com',
      '123456789',
      university,
      'Computer Science',
      '1234567890',
      '${DateTime.now()}',
      'Test User',
    );

    // Assert the test result
    expect(test, true);

    // Print the test result
    print('Student Registration Test $test');
  });
}

