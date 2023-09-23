import 'dart:typed_data';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:gp/auth/login.dart';
import 'package:gp/auth/model/student_auth_mode/student_auth_model.dart';
import 'package:gp/component/app_theme.dart';
import 'package:gp/dashboard/profile/profile.dart';
import 'package:gp/dashboard/skill/model/skill.dart';
import 'package:gp/firestore/firestore_services.dart';
import 'home/home_page.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:document_file_save_plus/document_file_save_plus.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  bool isResumeLoading = false;
  void _onItemTapped(int index) {
    setState(() {
      print('index: $index');
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
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
          // _pages[_selectedIndex],
          floatingActionButton: isResumeLoading
              ? const CircularProgressIndicator()
              : FloatingActionButton(
                  onPressed: () {
                    // Add your onPressed code here!
                    _openPopup(context);
                  },
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.add),
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 7,
            child: SizedBox(
              height: 60,
              child: Row(
                // This is main Axis
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      _onItemTapped(0);
                    },
                    child: Icon(
                      Icons.home,
                      color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      _onItemTapped(1);
                    },
                    child: Icon(
                      Icons.person,
                      color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
                    ),
                  )
                  // Row( // This is children of main Axis
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     MaterialButton(
                  //       minWidth: 40,
                  //       onPressed:(){_onItemTapped(0);} ,
                  //       child:  Icon(Icons.home, color: _selectedIndex ==0 ? Colors.blue : Colors.grey,),
                  //     ),
                  //     MaterialButton(
                  //       minWidth: 40,
                  //       onPressed:(){_onItemTapped(1);} ,
                  //       child:  Icon(Icons.person, color: _selectedIndex ==1 ? Colors.blue : Colors.grey,),
                  //     )
                  //   ],
                  // ),
                  // Row( // This is children of main Axis
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     MaterialButton(
                  //       minWidth: 40,
                  //       onPressed:(){_onItemTapped(2);} ,
                  //       child: Icon(Icons.notifications, color: _selectedIndex ==2 ? Colors.blue : Colors.grey,),
                  //     ),
                  //     // MaterialButton(
                  //     //   minWidth: 40,
                  //     //   onPressed:(){_onItemTapped(3);} ,
                  //     //   child: Icon(Icons.settings, color: _selectedIndex == 3 ? Colors.blue : Colors.grey,),
                  //     // )
                  //   ],
                  // )
                ],
              ),
            ),
          ));
    } else {
      // User is not logged in, navigate to login screen
      return const LoginPage();
    }
  }

  void _openPopup(BuildContext context) {
    final RenderBox fabRenderBox = context.findRenderObject() as RenderBox;

    final Offset fabOffset = fabRenderBox.localToGlobal(
      Offset(fabRenderBox.size.width / 2, fabRenderBox.size.height / 2),
    );
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        fabOffset.dx - 110.0, // Adjust this value for horizontal positioning
        fabOffset.dy +
            getPositioningValue(
                context), // Adjust this value for vertical positioning
        fabOffset.dx - 10.0, // Adjust this value for horizontal positioning
        fabOffset.dy - 90, // Adjust this value for vertical positioning
      ),
      items: <PopupMenuItem<String>>[
        PopupMenuItem(
          value: '1',
          child: const Text('Add new Skill'),
          onTap: () {
            context.go('/addSkill');
          },
        ),
        PopupMenuItem(
          value: '2',
          child: const Text('Set/Edit your Carrier Goal'),
          onTap: () {
            print('Add new Skill 2');
          },
        ),
        PopupMenuItem(
          value: '3',
          child: const Text('Build your Resume'),
          onTap: () {
            setState(() {
              isResumeLoading = true;
            });
            print('Add new Skill 3');
            goForResumeBuild(context);
          },
        ),
      ],
    );
  }

  num getPositioningValue(BuildContext context) {
    if (AppThemes.isTablet) {
      return 0;
    } else if (Orientation.landscape == MediaQuery.of(context).orientation) {
      return 0;
    } else {
      return 160;
    }
  }

  Future<void> goForResumeBuild(BuildContext context) async {
    final resumeData = {
      'fullName': 'John Doe',
      'email': 'john.doe@example.com',
      'phone': '123-456-7890',
      'address': '123 Main St, New York, NY 10001',
      'divider': '\n\n\n\n',


      'references': [
        {
          'name': 'Jane Doe',
          'reference': 'Reference 1',
        },
        {
          'name': 'John Doe',
          'reference': 'Reference 2',
        }
      ],

      // Add more resume information as needed
    };

    const outputPath =
        '/path/to/save/resume.pdf'; // Replace with your desired output path

    await generatePDFResume(resumeData);

    print('PDF resume generated at $outputPath');
  }

   Future<List<Skill>> fetchSkillListData() async {
    List<Skill> skillList = [];
    try {
      // Get the current user's UID
      final String? uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid != null) {
        // Reference to the 'skills' collection for the current user
        final CollectionReference skillsCollection =
        FirebaseFirestore.instance.collection('student/$uid/skills');

        // Get a snapshot of the documents in the collection
        final QuerySnapshot snapshot = await skillsCollection.get();

        // Loop through the documents
        snapshot.docs.forEach((DocumentSnapshot doc) {
          // Access the data in each document
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          // Now you can work with 'data'
          print('data: $data');
          skillList.add(Skill.fromSnapshot(data));
        });
      } else {
        print('User not authenticated or UID is null');
      }
    } catch (e) {
      print('Error: $e');
    }
    return skillList;
  }

  Future<void> generatePDFResume(Map<String, dynamic> resumeData) async {
    final pdf = pdfLib.Document();
    List<Skill> skillList = await fetchSkillListData();
    if(skillList.length < 3){
     showErrorDialog(context);
      return;
    }
    final StudentAuthModel student = await FireStoreService()
        .getStudentDetails(FirebaseAuth.instance.currentUser!.uid);


    print('skillList: $skillList');

    String careerObjective = 'As a recent graduate from ${student.university}, department of ${student.department}, I am eager to embark on a fulfilling career that allows me to apply the knowledge and skills I have gained throughout my academic journey. '
        'I am committed to leveraging my education and passion to contribute positively to a dynamic and innovative team while continuously learning and growing in a professional environment. My goal is to excel in [Your Chosen Field] and make meaningful contributions to the organization success.';

    // Add a page to the PDF document
    pdf.addPage(
      pdfLib.Page(
        build: (context) {
          return pdfLib.Center(
            child: pdfLib.Column(
              mainAxisAlignment: pdfLib.MainAxisAlignment.start,
              crossAxisAlignment: pdfLib.CrossAxisAlignment.start,
              children: <pdfLib.Widget>[
                pdfLib.Text(
                  'Resume',
                  style: const pdfLib.TextStyle(fontSize: 24),
                ),
                // SizedBox(height: 20),
                pdfLib.Text('Full Name: ${student.name}'),
                pdfLib.Text('Email: ${student.email}'),
                pdfLib.Text('Phone: ${resumeData['phone']}'),
                pdfLib.Text('Address: ${resumeData['address']}'),
                pdfLib.Text('DateOF Birth: ${student.dateOfBirth}'),

                pdfLib.Text('${resumeData['divider']}'),
                pdfLib.Text(
                  'Career Objective',
                  style: const pdfLib.TextStyle(fontSize: 18),
                  textAlign: pdfLib.TextAlign.left,
                ),
                pdfLib.Text(careerObjective),
                pdfLib.Text('${resumeData['divider']}'),
                pdfLib.Text(
                  'Education',
                  style: const pdfLib.TextStyle(fontSize: 18),
                  textAlign: pdfLib.TextAlign.left,
                ),
                pdfLib.Text(student.university.name),
                pdfLib.Text(student.department),

                pdfLib.Text('${resumeData['divider']}'),

                pdfLib.Text(
                  'Skills',
                  style: const pdfLib.TextStyle(fontSize: 18),
                  textAlign: pdfLib.TextAlign.left,
                ),

                for (var element in skillList) ...[
                  pdfLib.Text(
                    element.name,
                    style: const pdfLib.TextStyle(fontSize: 15),
                  ),
                  pdfLib.Text(
                    '${element.name}, ${element.courseLeaderName}, ${element.score}, ${element.courseWork}, ${element.project}',
                  ),
                ],

                pdfLib.Text('${resumeData['divider']}'),
                pdfLib.Text(
                  'References',
                  style: const pdfLib.TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: pdfLib.TextAlign.left,
                ),
                for (var element in skillList) ...[
                  pdfLib.Text(
                    element.courseLeaderName,
                    style: const pdfLib.TextStyle(fontSize: 15),
                  ),
                ],
                // Add more resume information as needed
              ],
            ),
          );
        },
      ),
    );

    print('PDF resume generated at $pdf');

    Uint8List pdfBytes = await pdf.save();

    DocumentFileSavePlus()
        .saveFile(pdfBytes, "my_resume.pdf", "appliation/pdf");

    // final dir = await getApplicationDocumentsDirectory();
    // final file = File("${dir.path}/${'my_resume.pdf'}");
    //
    // await file.writeAsBytes(pdfBytes);
    // final url = file.path;
    // print('url: $url');
    Fluttertoast.showToast(
      msg: "Please Check Your Download Folder!",
      toastLength: Toast.LENGTH_SHORT, // Duration for how long the toast should be displayed
      gravity: ToastGravity.BOTTOM,    // Toast gravity (TOP, CENTER, BOTTOM)
      backgroundColor: Colors.black.withOpacity(0.7), // Background color of the toast
      textColor: Colors.white,         // Text color of the toast message
      fontSize: 16.0,                 // Font size of the toast message
    );
    setState(() {
      isResumeLoading = false;
    });
     // context.go('/resume/${url.toString()}');

    // context.go('/skillValidation/$studentId/$skillId');

    //context.go('/resume/${url}');
  }

  void showErrorDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.error,
      showCloseIcon: true,
      title: 'Resume Error',
      desc: 'Please add at least 3 skills to your profile to generate your resume',
      btnOkOnPress: () {
        setState(() {
          isResumeLoading = false;
        });
      },
      btnOkIcon: Icons.check_circle,
      onDismissCallback: (type) {},
    ).show();

  }
}
