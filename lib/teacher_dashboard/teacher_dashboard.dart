import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/animated_list_tile.dart';

class TeacherDashBoard  extends StatelessWidget{
  const TeacherDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Students List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('student')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No Skill available. Please add your Skill'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data?.docs[index];
              var data = doc?.data() as Map<String, dynamic>;

              return Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: AnimatedListTile(
                  // contentPadding: const EdgeInsets.all(10),
                  title: Text(data['name']),
                  trailing: const Icon(Icons.arrow_forward_ios_sharp),
                  // IconButton(
                  //   icon: const Icon(Icons.arrow_forward_ios_sharp),
                  // ),
                  subtitle: const Text('IF this has any additional information'),
                  onTap: () {
                    print('ID: ${doc?.id}');
                    // context.goNamed("/addSkillDetails", pathParameters: {'id':'${doc?.id}', 'name':'${data['name']}'});
                    // context.go('/details/${data['name']}/${doc?.id}');
                  },

                ),
              );
            },
          );
        },
      ),
    );
  }

}