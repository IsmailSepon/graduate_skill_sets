import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gp/auth/model/department_model.dart';
import '../auth/model/university_model.dart';
import '../dashboard/skill/model/skill.dart';

class FireStoreService {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  addUniversity() {}

  getUniversityList() async {
    CollectionReference universityCollection =
        FirebaseFirestore.instance.collection('university');

    List<University> uniList = [];
    QuerySnapshot querySnapshot = await universityCollection.get();
    for (var snapshot in querySnapshot.docs) {
      uniList.add(University.fromSnapshot(snapshot, snapshot.id));
    }
    return uniList;
  }

  getDepartmentList() async {
    CollectionReference departmentCollection =
        FirebaseFirestore.instance.collection('department');

    List<Department> departmentList = [];
    QuerySnapshot querySnapshot = await departmentCollection.get();
    for (var snapshot in querySnapshot.docs) {
      departmentList.add(Department.fromSnapshot(snapshot, snapshot.id));
    }
    return departmentList;
  }

  void storeInformation(User user, University uni, String department,
      String studentId, String dateOfBirth, String name) {
    CollectionReference departmentCollection =
        FirebaseFirestore.instance.collection('student');
    departmentCollection.doc(user.uid).set({
      'name': name,
      'email': user.email,
      'university': uni.name,
      'universityID': uni.id,
      'department': department,
      'studentId': studentId,
      'dateOfBirth': dateOfBirth,
    });
  }

  bool sendValidation(
      String courseName,
      String courseLeaderMail,
      String courseLecturerMail,
      String additionalMessage,
      String courseWork,
      String project, String courseLeaderName) {
    Skill skill = Skill(courseName, 0, false, courseName, courseLeaderMail,
        courseLecturerMail, additionalMessage, '', courseWork, '', project, '', courseLeaderName);

    CollectionReference departmentCollection =
        FirebaseFirestore.instance.collection('student');
    departmentCollection.doc(uid).collection('skills').add(skill.toJson());

    return true;
    // stream: FirebaseFirestore.instance.collection('student').doc(uid).collection('skills').snapshots(),
  }
}
