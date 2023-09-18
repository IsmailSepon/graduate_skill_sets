import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:gp/auth/model/university_model.dart';
import 'package:gp/firestore/firestore_services.dart';
import '../../component/long_button.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';
import '../model/department_model.dart';

class TeacherRegistration extends StatefulWidget {
  const TeacherRegistration({super.key});

  @override
  State<TeacherRegistration> createState() => _TeacherRegistrationState();
}

class _TeacherRegistrationState extends State<TeacherRegistration> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _department_controller = TextEditingController();

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
          title: const Text('Teacher Registration Page'),
        ),
        body: BlocBuilder<GPAuthCubit, AuthState>(builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                    onChanged: (value) {
                      context
                          .read<GPAuthCubit>()
                          .updateSinglePropertyOnState('password', value);
                    },
                    keyboardType: TextInputType.visiblePassword,
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
                        state.department.isEmpty,
                    onPressed: () {
                      context
                          .read<GPAuthCubit>()
                          .teacherRegister(context);
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
                        onPressed: () {
                          context.go('/login');
                        },
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
