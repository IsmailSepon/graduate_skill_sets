import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class University extends Equatable{
   final String name;
   final String id;


    const University({
      required this.name,
      required this.id,
   });

  @override
  List<Object?> get props =>[name];


  static University fromSnapshot(DocumentSnapshot snap, String id) {
    University university = University(
      name: snap['name'],
      id: id,
    );
    return university;
  }


  University.fromJson(Map<String, dynamic> json, this.id )
      : name = json['name'];


  static List<University> universityList = [
      University(name: 'Staffordshire University', id: '1'),
      University(name: 'Manchester University', id: '2'),
      University(name: 'birmingham University', id: '3'),
      University(name: 'Coventry University', id: '4'),
  ];



}