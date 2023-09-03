import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp/auth/login.dart';
import 'package:gp/auth/registration.dart';
import 'package:gp/dashboard/profile/profile.dart';
import 'package:intl/intl.dart';

import 'home/home_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      print('index: $index');
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const Profile(),
    const Profile(),
    const Profile(),
  ];


  @override
  Widget build(BuildContext context) {

    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return Scaffold(
        // appBar: AppBar(
        //   title: Text(DateFormat('dd-MMMM').format(DateTime.now())),
        // ),
        body: _pages[_selectedIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar:  BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 7,
          child: SizedBox(
            height: 60,
            child: Row( // This is main Axis
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row( // This is children of main Axis
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed:(){_onItemTapped(0);} ,
                      child:  Icon(Icons.home, color: _selectedIndex ==0 ? Colors.blue : Colors.grey,),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed:(){_onItemTapped(1);} ,
                      child:  Icon(Icons.person, color: _selectedIndex ==1 ? Colors.blue : Colors.grey,),
                    )
                  ],
                ),
                Row( // This is children of main Axis
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed:(){_onItemTapped(2);} ,
                      child: Icon(Icons.notifications, color: _selectedIndex ==2 ? Colors.blue : Colors.grey,),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed:(){_onItemTapped(3);} ,
                      child: Icon(Icons.settings, color: _selectedIndex == 3 ? Colors.blue : Colors.grey,),
                    )
                  ],
                )
              ],

            ),
          ),
        )

      );
    } else {
      // User is not logged in, navigate to login screen
      return const LoginPage();
    }
  }
}
