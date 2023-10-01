import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gp/auth/model/department_model.dart';
import 'package:gp/auth/model/skill_model.dart';
import 'package:gp/auth/model/student_auth_mode/student_auth_model.dart';
import '../auth/model/university_model.dart';
import '../dashboard/skill/model/skill.dart';

class FireStoreService {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  addUniversity() {}

  getSkillNameList() async {
    CollectionReference universityCollection =
        FirebaseFirestore.instance.collection('skill_set');

    List<SkillModel> skillList = [];
    QuerySnapshot querySnapshot = await universityCollection.get();
    for (var snapshot in querySnapshot.docs) {
      skillList.add(SkillModel.fromSnapshot(snapshot, snapshot.id));
    }
    return skillList;
  }

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

  getStudentDetailsFromFirebase(String uid) async {
    StudentAuthModel student = StudentAuthModel.empty;
    final doc = await firestore
        .collection('student')
        .doc(uid)
        .get();

    if (doc.exists) {
      student = student.fromSnapshot(doc);
    } else {
      print('Student document not found.');
    }

    return student;
  }

  void storeTeacherInformation(User user, University uni, String department, String name) {
    CollectionReference departmentCollection =
        FirebaseFirestore.instance.collection('teacher');
    departmentCollection.doc(user.uid).set({
      'name': name,
      'email': user.email,
      'university': uni.name,
      'universityID': uni.id,
      'department': department,
    });
  }

  String getSkillName(String skillID) {
    print('skillID: $skillID');
    String skillName = '';
    CollectionReference departmentCollection =
        FirebaseFirestore.instance.collection('skill');
    departmentCollection.doc(skillID).get().then((value) {
      skillName = value.get('name');
    });
    print('SkillName: $skillName');

    return skillName;
  }

  bool sendValidation(
      String courseName,
      String courseLeaderMail,
      String courseLecturerMail,
      String additionalMessage,
      String courseWork,
      String project,
      String courseLeaderName, String skillName) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    Skill skill = Skill(
        skillName,
        0,
        false,
        courseName,
        courseLeaderMail,
        courseLecturerMail,
        additionalMessage,
        '',
        courseWork,
        '',
        project,
        '',
        courseLeaderName);

    CollectionReference departmentCollection =
        FirebaseFirestore.instance.collection('student');
    departmentCollection.doc(uid).collection('skills').add(skill.toJson());

    return true;
    // stream: FirebaseFirestore.instance.collection('student').doc(uid).collection('skills').snapshots(),
  }


  getStudentDetails(String studentID) async {
    StudentAuthModel student = StudentAuthModel.empty;
    final doc =  await firestore
        .collection('student')
        .doc(studentID)
        .get();//.then((value) => StudentAuthModel.fromSnapshot(value));


    if (doc.exists) {
      student = student.fromSnapshot(doc);
    } else {
      print('Student document not found.');
      return student;
    }
    return student;
  }

  Future<Skill> getSkillDetails(String studentID, String skillID) async {
    print('skillID: $skillID, studentID: $studentID');
    Skill skill = Skill.empty;

    final doc = await firestore
        .collection('student')
        .doc(studentID)
        .collection('skills')
        .doc(skillID)
        .get();

    if (doc.exists) {
      skill = Skill.fromDocumentSnapshot(doc);
      print('skill: $skill');
    } else {
      print('Skill document not found.');
    }

    return skill;
  }

  updateSkillRating(String studentID, String skillID, double rating) {
    CollectionReference departmentCollection = FirebaseFirestore.instance.collection('student');
    departmentCollection.doc(studentID).collection('skills').doc(skillID).update({'score': rating});
    departmentCollection.doc(studentID).collection('skills').doc(skillID).update({'verifyStatus': true});
  }

  static String getTeacher(String uid) {
    String teacherName = '';
    if (uid.isEmpty) {
      return teacherName;
    }

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference departmentCollection =
    firestore.collection('teacher');
    departmentCollection.doc(uid).get().then((value) {
      teacherName = value.get('name');
      print('Teacher Name: ${value.get('name')}');
    });

    return teacherName;
  }

  void storeDreamJob(String text) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference departmentCollection =
        FirebaseFirestore.instance.collection('student');
    departmentCollection.doc(uid).update({'dreamJob': text});
  }

}
