import 'package:equatable/equatable.dart';

import '../../skill/model/skill.dart';
import '../model/student.dart';

class ValidationState extends Equatable {
  final String rating;
  final bool isLoading;
  final Student student;
  final Skill skill;

  ValidationState({
    Student? student,
    Skill? skill,
    this.rating = '',
    this.isLoading = false,
  })  : student = student ?? Student.empty,
        skill = skill ?? Skill.empty;

  @override
  List<Object?> get props => [rating, isLoading];

  factory ValidationState.initial() {
    return ValidationState();
  }

  get _toMap => {
        'rating': rating,
        'isLoading': isLoading,
        'student': student,
        'skill': skill,
      };

  get status => null;

  // get isLoading => isLoading;

  ValidationState copySingleProperty(String key, value) {
    var newMap = _toMap;
    newMap[key] = value;
    return ValidationState(
      rating: newMap['rating'],
      isLoading: newMap['isLoading'],
      student: newMap['student'],
      skill: newMap['skill']
    );
  }
}
