import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gp/auth/model/university_model.dart';
import 'package:gp/firestore/firestore_services.dart';
import 'package:intl/intl.dart';

import '../component/long_button.dart';
import 'bloc/auth_cubit.dart';
import 'bloc/auth_state.dart';
import 'model/department_model.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _department_controller = TextEditingController();
  final TextEditingController _course_controller = TextEditingController();

  List<University> universityList = [];
  List<Department> departmentList = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    FireStoreService fireStoreService = FireStoreService();
    loadUniversity(fireStoreService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Student Registration Page'),
        ),
        body: BlocBuilder<GPAuthCubit, AuthState>(builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      print('Name: $value');
                      context
                          .read<GPAuthCubit>()
                          .updateSinglePropertyOnState('name', value);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                        text: state.dateOfBirth == ''
                            ? ''
                            : state.dateOfBirth.toString()),
                    onTap: () async {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext modalContext) {
                          return Container(
                            height: 200,
                            color: Colors.white,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              // initialDateTime: value,
                              backgroundColor: CupertinoColors.systemBackground
                                  .resolveFrom(context),
                              onDateTimeChanged: (DateTime value) {/**/
                                context
                                    .read<GPAuthCubit>()
                                    .updateSinglePropertyOnState(
                                        'dateOfBirth', DateFormat("yyyy-MM-dd").format(value));
                              },
                            ),
                          );
                        },
                      );
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your date of birth',
                      labelText: 'Date of Birth',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'University',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      return universityList.where((university) => university
                          .name
                          .toLowerCase()
                          .contains(pattern.toLowerCase()));
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion.name),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      _controller.text = suggestion.name;
                      context.read<GPAuthCubit>().updateSinglePropertyOnState(
                          'university', suggestion);
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _department_controller,
                      decoration: const InputDecoration(
                        labelText: 'Department',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      return departmentList.where((university) => university
                          .name
                          .toLowerCase()
                          .contains(pattern.toLowerCase()));
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion.name),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      _department_controller.text = suggestion.name;
                      context.read<GPAuthCubit>().updateSinglePropertyOnState(
                          'department', suggestion.name);
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      context
                          .read<GPAuthCubit>()
                          .updateSinglePropertyOnState('email', value);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      labelText: 'University Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                   // validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
                    onChanged: (value) {
                      context
                          .read<GPAuthCubit>()
                          .updateSinglePropertyOnState('studentId', value);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your University ID',
                      labelText: 'University ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      context
                          .read<GPAuthCubit>()
                          .updateSinglePropertyOnState('password', value);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  LongButton(
                    isLoading: state.isLoading,
                    isDisabled: state.name.isEmpty ||
                        state.email.isEmpty ||
                        state.password.isEmpty ||
                        state.university.name.isEmpty ||
                        state.department.isEmpty ||
                        // state.dateOfBirth.isEmpty ||
                        state.studentId.isEmpty,
                    onPressed: () {
                      context
                          .read<GPAuthCubit>()
                          .register();
                    },
                    child: const Text('Register'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }

  Future<void> loadUniversity(FireStoreService fireStoreService) async {
    universityList.clear();
    universityList = await fireStoreService.getUniversityList();
    print('Unilist: $universityList');
    loadDepartment(fireStoreService);
  }

  Future<void> loadDepartment(FireStoreService fireStoreService) async {
    departmentList.clear();
    departmentList = await fireStoreService.getDepartmentList();
    print('Unilist: $departmentList');
  }
}
