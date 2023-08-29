import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gp/auth/model/department_model.dart';
import '../auth/model/university_model.dart';

class FireStoreService{
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collection = FirebaseFirestore.instance.collection('gp');
  CollectionReference universityCollection = FirebaseFirestore.instance.collection('university');


  addUniversity(){

  }

  getUniversityList() async {
    CollectionReference universityCollection = FirebaseFirestore.instance.collection('university');

    List<University> uniList = [];
    QuerySnapshot querySnapshot = await universityCollection.get();
    for (var snapshot in querySnapshot.docs) {
      uniList.add(University.fromSnapshot(snapshot, snapshot.id));
    }
    print('Unilist: $uniList');
    return uniList;
  }

  getDepartmentList() async {
    CollectionReference departmentCollection = FirebaseFirestore.instance.collection('department');

    List<Department> departmentList = [];
    QuerySnapshot querySnapshot = await departmentCollection.get();
    for (var snapshot in querySnapshot.docs) {
      departmentList.add(Department.fromSnapshot(snapshot, snapshot.id));
    }
    print('Unilist: $departmentList');
    return departmentList;
  }

}