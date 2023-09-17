import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gp/auth/login.dart';
import 'package:gp/component/app_theme.dart';
import 'package:gp/dashboard/profile/profile.dart';
import 'package:gp/dashboard/skill/model/validation_request.dart';

import '../firebaseDynamicLink/firebase_fynamic_link_service.dart';
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
    if (user != null && user.emailVerified) {
      return Scaffold(
        // appBar: AppBar(
        //   title: Text(DateFormat('dd-MMMM').format(DateTime.now())),
        // ),
        body: _pages[_selectedIndex],
        floatingActionButton:
        FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            _openPopup(context);
          },
          backgroundColor: Colors.blue,
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

  void _openPopup(BuildContext context) {
    final RenderBox fabRenderBox = context.findRenderObject() as RenderBox;

    final Offset fabOffset = fabRenderBox.localToGlobal(
      Offset(fabRenderBox.size.width / 2, fabRenderBox.size.height/2),
    );
    showMenu(
      context: context,
      position:
      RelativeRect.fromLTRB(
         fabOffset.dx - 110.0, // Adjust this value for horizontal positioning
        fabOffset.dy + getPositioningValue(context), // Adjust this value for vertical positioning
        fabOffset.dx - 10.0, // Adjust this value for horizontal positioning
        fabOffset.dy -90, // Adjust this value for vertical positioning
      ),
      items: <PopupMenuItem<String>>[
        PopupMenuItem(
          value: '1',
          child: const Text('Add new Skill'),
          onTap: (){
            context.go('/addSkill');
          },
        ),
        PopupMenuItem(
          value: '2',
          child: const Text('Set/Edit your Carrier Goal'),
          onTap: (){

            print('Build your Resume');
          },
        ),
        PopupMenuItem(
          value: '3',
          child: const Text('Build your Resume'),
          onTap: (){

            print('Add new Skill 3');
          },
        ),

      ],
    );
  }

  num getPositioningValue(BuildContext context) {
    if (AppThemes.isTablet) {
      return 0;
    } else if (Orientation.landscape == MediaQuery
        .of(context)
        .orientation) {
      return 0;
    } else {
      return 160;
    }
  }
}
