import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../university_model.dart';

class StudentAuthModel extends Equatable{
  final String email;
  final String name;
  final String dateOfBirth;
  final University university;
  final String department;
  final String studentId;
  final String dreamJob;
  // final String password;

  static StudentAuthModel empty = const StudentAuthModel('', '', '', University(name: '', id: ''), '', '','');

  const StudentAuthModel(this.email, this.name, this.dateOfBirth, this.university, this.department, this.studentId, this.dreamJob);

  @override
  List<Object?> get props => [name, email, dateOfBirth, university, department, studentId];

   fromSnapshot(DocumentSnapshot<Map<String, dynamic>> value) {
    return StudentAuthModel(
      value.data()!['email'],
      value.data()!['name'],
      value.data()!['dateOfBirth'],
      University(name: '${value.data()!['university']}', id: '${value.data()!['universityID']}'),
      value.data()!['department'],
      value.data()!['studentId'],
      value.data()!['dreamJob'] =='' ? '': value.data()!['dreamJob']
    );
  }
}