import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Course extends Equatable{
   final String name;
   final String id;


    const Course({
      required this.name,
      required this.id,
   });

  @override
  List<Object?> get props =>[name];


  static Course fromSnapshot(DocumentSnapshot snap, String id) {
    Course university = Course(
      name: snap['name'],
      id: id,
    );
    return university;
  }


   Course.fromJson(Map<String, dynamic> json, this.id )
      : name = json['name'];






}