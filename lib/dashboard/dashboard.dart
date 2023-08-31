import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp/auth/login.dart';
import 'package:gp/auth/registration.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {

    User? user = FirebaseAuth.instance.currentUser;

    print('user $user');
    if (user != null) {
      // User is already logged in, navigate to dashboard
      return const Registration();
    } else {
      // User is not logged in, navigate to login screen
      return const LoginPage();
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('dd-MMMM').format(DateTime.now())),
      ),
      body: const Center(
        child: Text('Dashboard'),
      ),
    );
  }
}