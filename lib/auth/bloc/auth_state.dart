import 'package:equatable/equatable.dart';

import '../model/university_model.dart';

class AuthState extends Equatable {
  final List<University> universityList;
  final String email;
  final String dateOfBirth;
  final String universityName;
  final String department;
  final String studentId;
  final String courseName;
  final String password;

  const AuthState(
      this.universityList,
      this.email,
      this.dateOfBirth,
      this.universityName,
      this.department,
      this.studentId,
      this.courseName,
      this.password);

  AuthState copyWith({
    List<University>? universityList,
    String? email,
    String? dateOfBirth,
    String? universityName,
    String? department,
    String? studentId,
    String? courseName,
    String? password,
  }) =>
      AuthState(
        universityList ?? this.universityList,
        email ?? this.email,
        dateOfBirth ?? this.dateOfBirth,
        universityName ?? this.universityName,
        department ?? this.department,
        studentId ?? this.studentId,
        courseName ?? this.courseName,
        password ?? this.password,
      );



  @override
  List<Object?> get props => [];

  factory AuthState.initial() {
    return const AuthState(
      [],
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    );
  }
}

// class AuthInitial extends AuthState {
//   late List<University> university;
//   @override
//   List<Object> get props => [university];
// }
//
// class AuthLoading extends AuthState {
//   @override
//   List<Object> get props => [];
// }
//
// class Registration extends AuthState {
//   @override
//   List<Object> get props => [];
// }
//
// class Login extends AuthState {
//   @override
//   List<Object> get props => [];
// }
