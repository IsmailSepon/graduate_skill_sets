import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../component/skill_list_tile.dart';
import '../skill/model/skill.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('Home Page'),
     ),
     body: const SkillsListView(),
   );
  }
}


class SkillsListView extends StatelessWidget {
  const SkillsListView({super.key});


  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    print('uid: $uid');
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('student').doc(uid).collection('skills').snapshots(),
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
            Skill skill = Skill.fromSnapshot(data);
            print('skill: $skill');

            return SkillListTile(skill: skill);
            // return Padding(
            //   padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            //   child: AnimatedListTile(
            //     leading: Image.asset('assets/skill_icon.jpg', height: 300,),//CircleAvatar(child: Image.asset('assets/skill_icon.jpg', height: 300,)),
            //
            //     title: Text(skill.name),//Text(data['name']),
            //     borderRadius: const BorderRadius.all(Radius.circular(0)),
            //     trailing: const Icon(Icons.blur_on_rounded),
            //     // IconButton(
            //     //   icon: const Icon(Icons.arrow_forward_ios_sharp),
            //     // ),
            //     subtitle: const Text('IF this has any additional information'),
            //     onTap: () {
            //       // print('ID: ${doc?.id}');
            //       // // context.goNamed("/addSkillDetails", pathParameters: {'id':'${doc?.id}', 'name':'${data['name']}'});
            //       // context.go('/details/${data['name']}/${doc?.id}');
            //     },
            //
            //   ),
            // );

            // return ListTile(
            //   contentPadding: const EdgeInsets.all(10.0),
            //   title: Text(data['name']),
            // );
          },
        );
      },
    );
  }
}