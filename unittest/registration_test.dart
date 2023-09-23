 // Import your Dashboard widget

 // Create a mock UserRepository

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gp/auth/model/university_model.dart';
import 'package:gp/auth/repo/auth_repository.dart';
import 'package:gp/firebase_options.dart';

void main() {

  test('Student Registration', () async {
    // Initialize Firebase
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    // Create a mock University object
    University university = const University(
        name: 'Test University', id: '1234567890');

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


    print('Student Registration Test $test');
  });

}

