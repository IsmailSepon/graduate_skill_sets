import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gp/auth/model/university_model.dart';
import 'package:gp/firestore/firestore_services.dart';

import '../component/long_button.dart';
import 'bloc/auth_cubit.dart';
import 'bloc/auth_state.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _controller = TextEditingController();

   List<University> universityList = [];

  // @override
  // initState() async {
  //   super.initState();
  //   _initData();
  // }
  // Future<List<University>>? universityList;

  @override
  void initState() {
    super.initState();
    // universityList = FireStoreService().getUniversityList();
    _initData();
  }
  Future<void> _initData() async {
    universityList.clear();
    CollectionReference universityCollection = FirebaseFirestore.instance.collection('university');
    QuerySnapshot querySnapshot = await universityCollection.get();
    for (var snapshot in querySnapshot.docs) {
      universityList.add(University.fromSnapshot(snapshot, snapshot.id));
    }
    print('Unilist: $universityList');
    // return uniList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: BlocBuilder<GPAuthCubit, AuthState>(builder: (context, state) {
          context.read<GPAuthCubit>().getUniversityList();
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                      labelText: 'Name',
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
                      return universityList.where((university) => university.name
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
                    },
                  ),

                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'Confirm your password',
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  LongButton(
                    onPressed: () {
                      context
                          .read<GPAuthCubit>()
                          .register('ismail@gmail.com', '12345567788');
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
}
