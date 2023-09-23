import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gp/dashboard/validation/bloc/validation_state.dart';

import '../../auth/login.dart';
import '../../component/animated_list_tile.dart';
import '../../component/input_duration.dart';
import '../../component/list_tile_border_radius.dart';
import '../../component/long_button.dart';
import '../../firestore/firestore_services.dart';
import 'bloc/validation_cubit.dart';

class SkillValidation extends StatefulWidget {
  final String? skillID;
  final String? studentID;

  const SkillValidation(
      {super.key, required this.skillID, required this.studentID});

  @override
  State<SkillValidation> createState() => _SkillValidationState();
}

class _SkillValidationState extends State<SkillValidation> {

  double _rating = 0;
  TextEditingController inputController = TextEditingController();
  late String teacherName = '';
  final User? user = FirebaseAuth.instance.currentUser;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    inputController.addListener(_updateRating);
    //
    //  final User? user = FirebaseAuth.instance.currentUser;
    // String teacherName = FireStoreService.getTeacher(user?.uid ?? '');

    isLoading = true;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference departmentCollection =
    firestore.collection('teacher');
    departmentCollection.doc(user?.uid).get().then((value) {
      // teacherName = value.get('name');
      setState(() {
        teacherName = value.get('name');
        isLoading = false;
      });
      print('Teacher Name: ${value.get('name')}');
    });
  }

  void _updateRating() {
    setState(() {
      // Parse the input as a double and update the rating
      _rating = double.tryParse(inputController.text) ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(isLoading){
      return const Center(child: CircularProgressIndicator());
    }

    if (teacherName.isNotEmpty) {
      return BlocProvider(
        create: (context) =>
            ValidationCubit(skillID: widget.skillID, studentID: widget.studentID),
        child: BlocBuilder<ValidationCubit, ValidationState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Skill Validation Request'),
                ),
                body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
// padding: const EdgeInsets.all(10.0),
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          AnimatedListTile(
                            borderRadius: ListTileBorderRadius.onlyTop,
                            title: const Text('Student Name'),
                            trailing: Text(
                              state.student.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          AnimatedListTile(
                            borderRadius: ListTileBorderRadius.none,
                            title: const Text('Department'),
                            trailing: Text(
                              state.student.department,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          AnimatedListTile(
                            borderRadius: ListTileBorderRadius.none,
                            title: const Text('Course'),
                            trailing: Text(
                              state.skill.courseName,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          AnimatedListTile(
                            borderRadius: ListTileBorderRadius.none,
                            title: const Text('Student ID'),
                            trailing: Text(
                              state.student.studentId,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          AnimatedListTile(
                            borderRadius: ListTileBorderRadius.none,
                            title: const Text('Course Work'),
                            trailing: Text(
                              state.skill.courseWork,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          AnimatedListTile(
                            borderRadius: ListTileBorderRadius.onlyBottom,
                            title: const Text('Project Link'),
                            trailing: Text(
                              state.skill.project,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          // Expanded(
                          //   child:

                          RatingBar.builder(
                            initialRating:double.tryParse(state.rating) ?? 0 ,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 40,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                _rating = rating;
                                inputController.text = rating.toString();
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              inputFormatters: [
                                NumericalRangeFormatter(min: 0, max: 5)
                              ],
                              controller: inputController,
                              keyboardType:
                              const TextInputType.numberWithOptions(decimal: true),
                              decoration: const InputDecoration(
                                labelText: 'Rating Input out of 5',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                // inputController.text = value;
                                context.read<ValidationCubit>().updateSinglePropertyOnState('rating', value);

                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          LongButton(
                            isLoading: state.isLoading,
                            isDisabled:state.rating.isEmpty,
                            onPressed: () {

                              context.read<ValidationCubit>().updateTheRating(context);
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    )),
              );
            }),
      );
    } else {
      Fluttertoast.showToast(
        msg: "Please Login as a Teacher!",
        toastLength: Toast.LENGTH_SHORT, // Duration for how long the toast should be displayed
        gravity: ToastGravity.BOTTOM,    // Toast gravity (TOP, CENTER, BOTTOM)
        backgroundColor: Colors.black.withOpacity(0.7), // Background color of the toast
        textColor: Colors.white,         // Text color of the toast message
        fontSize: 16.0,                 // Font size of the toast message
      );
      if(user != null && teacherName.isNotEmpty){
        FirebaseAuth.instance.signOut();
      }
      return const LoginPage();
    }

  }
}
