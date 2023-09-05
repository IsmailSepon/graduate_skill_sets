import 'package:equatable/equatable.dart';

class AddSkillDetailsState extends Equatable {
  final bool isLoading;
  final String courseName;
  final String courseLeaderMail;
  final String courseLecturerMail;
  final String additionalMessage;
  final String courseWork;
  final String project;
  final String courseLeaderName;

  const AddSkillDetailsState({
    this.isLoading = false,
    this.courseName = '',
    this.courseLecturerMail = '',
    this.courseLeaderMail = '',
    this.additionalMessage = '',
    this.courseWork = '',
    this.project = '',
    this.courseLeaderName = '',
  });

  @override
  List<Object?> get props => [
        isLoading,
        courseName,
        courseLeaderMail,
        additionalMessage,
        courseLecturerMail,
        courseWork,
        project,
        courseLeaderName
      ];

  factory AddSkillDetailsState.initial() {
    return const AddSkillDetailsState();
  }

  get _toMap => {
        'courseName': courseName,
        'courseLeaderMail': courseLeaderMail,
        'courseLecturerMail': courseLecturerMail,
        'additionalMessage': additionalMessage,
        'isLoading': isLoading,
        'courseWork': courseWork,
        'project': project,
        'courseLeaderName': courseLeaderName,
      };


  AddSkillDetailsState copySingleProperty(String key, value) {
    var newMap = _toMap;
    newMap[key] = value;
    return AddSkillDetailsState(
      isLoading: newMap['isLoading'],
      courseName: newMap['courseName'],
      courseLeaderMail: newMap['courseLeaderMail'],
      courseLecturerMail: newMap['courseLecturerMail'],
      additionalMessage: newMap['additionalMessage'],
      courseWork: newMap['courseWork'],
      project: newMap['project'],
      courseLeaderName: newMap['courseLeaderName'],
    );
  }
}
