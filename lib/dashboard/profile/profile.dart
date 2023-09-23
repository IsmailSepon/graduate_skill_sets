import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gp/component/long_button.dart';
import 'package:gp/dashboard/profile/bloc/profile_cubit.dart';
import 'package:gp/dashboard/profile/bloc/profile_state.dart';

import '../../component/set_carrier_goal.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return BlocProvider(
      create: (context) => ProfileCubit(studentID: user?.uid),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.person_outlined),
                      title: Text(
                        user?.displayName ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      // trailing: Icon(Icons.person_outlined),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.calendar_month_sharp),
                      title: Text(
                        state.student.dateOfBirth ?? '',
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                      // trailing: Icon(Icons.person_outlined),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: Text(
                        state.student.university.name ?? '',
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                      // trailing: Icon(Icons.person_outlined),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.history_edu),
                      title: Text(
                        state.student.department ?? '',
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                      // trailing: Icon(Icons.person_outlined),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: Text(
                        state.student.email ?? '',
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                      // trailing: Icon(Icons.person_outlined),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.perm_identity_sharp),
                      title: Text(
                        'Student ID: ${state.student.studentId}',
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                      trailing: const Icon(Icons.edit),
                    ),
                    const Divider(height: 0),
                    GestureDetector(
                      onTap: () {
                        // context.go('/dreamJob');
                        print('Carrier Goal');

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const CustomDialogBox(
                                title: "Your Dream JOB",
                                // descriptions: "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                                text: "Yes", key: null,
                              );
                            });
                      },
                      child: ListTile(
                        leading: const Icon(Icons.home_repair_service),
                        title: Text(
                          state.student.dreamJob == ''
                              ? 'Set Your Dream Job'
                              : 'Your Dream Job: ${state.student.dreamJob}',
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                        trailing: const Icon(Icons.edit),
                      ),
                    ),
                    const Divider(height: 0),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 100),
                      child: LongButton(
                        color: Colors.red,
                        onPressed: () {
                          // context
                          //     .read<ProfileCubit>()
                          //     .updateSinglePropertyOnState('isLoading', true);
                          FirebaseAuth.instance.signOut();
                          context.go('/');
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
