import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../university_model.dart';

class StudentAuthModel extends Equatable{
  final String email;
  final String name;
  final String dateOfBirth;
  final University university;
  final String department;
  final String studentId;
  final String courseName;
  final String password;




  const StudentAuthModel(this.email, this.name, this.dateOfBirth, this.university, this.department, this.studentId, this.courseName, this.password);

  @override
  List<Object?> get props => [name, email, dateOfBirth, university, department, studentId, courseName, password];

  static fromSnapshot(DocumentSnapshot<Map<String, dynamic>> value) {
    return StudentAuthModel(
      value.data()!['email'],
      value.data()!['name'],
      value.data()!['dateOfBirth'],
      // University.fromSnapshot(value.data()!['university']),
      const University(name: '', id: ''),
      value.data()!['department'],
      value.data()!['studentId'],
      value.data()!['courseName'],
      value.data()!['password'],
    );
  }
}