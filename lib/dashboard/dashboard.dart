import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {

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