import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SkillModel extends Equatable{
   final String name;
   final String id;

  static get empty => const SkillModel(name: '', id: '');


    const SkillModel({
      required this.name,
      required this.id,
   });

  @override
  List<Object?> get props =>[name, id];


  static SkillModel fromSnapshot(DocumentSnapshot snap, String id) {
    SkillModel skillModel = SkillModel(
      name: snap['name'],
      id: id,
    );
    return skillModel;
  }


   SkillModel.fromJson(Map<String, dynamic> json, this.id )
      : name = json['name'];

}