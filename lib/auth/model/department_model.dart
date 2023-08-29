import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Department extends Equatable{
   final String name;
   final String id;


    const Department({
      required this.name,
      required this.id,
   });

  @override
  List<Object?> get props =>[name];


  static Department fromSnapshot(DocumentSnapshot snap, String id) {
    Department university = Department(
      name: snap['name'],
      id: id,
    );
    return university;
  }


   Department.fromJson(Map<String, dynamic> json, this.id )
      : name = json['name'];






}