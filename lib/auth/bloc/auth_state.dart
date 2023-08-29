import 'package:equatable/equatable.dart';

import '../model/university_model.dart';

class AuthState extends Equatable {
  final String email;
  final String name;
  final String dateOfBirth;
  final University university;
  final String department;
  final String studentId;
  final String courseName;
  final String password;

  const AuthState({
      this.email = '',
      this.dateOfBirth = '',
      this.university =  const University(name: '', id: ''),
      this.department = '',
      this.studentId = '',
      this.courseName = '',
      this.password = '', this.name = '',});



  @override
  List<Object?> get props => [name, email, dateOfBirth, university, department, studentId, courseName, password];

  factory AuthState.initial() {
    return   const AuthState();
  }
  get _toMap => {
    'email': email,
    'dateOfBirth': dateOfBirth,
    'university': university,
    'department': department,
    'studentId': studentId,
    'courseName': courseName,
    'password': password,
    'name': name,
  };


  AuthState copySingleProperty(String key, value) {
    var newMap = _toMap;
    newMap[key] = value;
    return  AuthState(
      email : newMap['email'],
      dateOfBirth: newMap['dateOfBirth'],
      university: newMap['university'],
      department: newMap['department'],
      studentId: newMap['studentId'],
      courseName: newMap['courseName'],
      password: newMap['password'],
      name: newMap['name'],
    );
  }
}

