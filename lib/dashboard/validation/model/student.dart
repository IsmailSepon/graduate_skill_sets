import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Student extends Equatable{
  final String email;
  final String name;
  final String department;



  const Student({
    required this.email,
    required this.name,
    required this.department,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [email, name, department];

  static Student get empty => const Student(email: '', name: '', department: '');

  static fromSnapshot(DocumentSnapshot<Map<String, dynamic>> value) {
    return Student(
      email: value.data()!['email'],
      name: value.data()!['name'],
      department: value.data()!['department'],
    );
  }
}