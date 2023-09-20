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
            return SkillListTile(skill: skill);
          },
        );
      },
    );
  }
}