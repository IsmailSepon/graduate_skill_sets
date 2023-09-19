import 'package:equatable/equatable.dart';
import 'package:gp/auth/model/student_auth_mode/student_auth_model.dart';

import '../../skill/model/skill.dart';

class ProfileState extends Equatable {
  final String rating;
  final bool isLoading;
  final StudentAuthModel student;
  final Skill skill;

  ProfileState({
    StudentAuthModel? student,
    Skill? skill,
    this.rating = '',
    this.isLoading = false,
  })  : student = student ?? StudentAuthModel.empty,
        skill = skill ?? Skill.empty;

  @override
  List<Object?> get props => [rating, isLoading];

  factory ProfileState.initial() {
    return ProfileState();
  }

  get _toMap => {
        'rating': rating,
        'isLoading': isLoading,
        'student': student,
        'skill': skill,
      };

  get status => null;

  // get isLoading => isLoading;

  ProfileState copySingleProperty(String key, value) {
    var newMap = _toMap;
    newMap[key] = value;
    return ProfileState(
      rating: newMap['rating'],
      isLoading: newMap['isLoading'],
      student: newMap['student'],
      skill: newMap['skill']
    );
  }
}
