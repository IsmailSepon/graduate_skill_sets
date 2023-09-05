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
  List<Object?> get props =>[name, id];


  static University fromSnapshot(DocumentSnapshot snap, String id) {
    University university = University(
      name: snap['name'],
      id: id,
    );
    return university;
  }


  University.fromJson(Map<String, dynamic> json, this.id )
      : name = json['name'];

}