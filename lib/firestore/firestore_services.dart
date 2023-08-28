import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import '../auth/model/university_model.dart';

class FireStoreService{
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collection = FirebaseFirestore.instance.collection('gp');
  CollectionReference universityCollection = FirebaseFirestore.instance.collection('university');


  addUniversity(){

  }

 Future<List<University>> getUniversityList() async {
    List<University> uniList = [];
    QuerySnapshot querySnapshot = await universityCollection.get();
    for (var snapshot in querySnapshot.docs) {
      uniList.add(University.fromSnapshot(snapshot, snapshot.id));
    }
    return uniList;
  }

}