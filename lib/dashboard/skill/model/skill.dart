import 'package:equatable/equatable.dart';

class Skill extends Equatable {
  final String name; //by student
  final int score; // teacher
  final bool verifyStatus; //teacher
  final String courseName; //student
  final String courseLeaderMail; //student
  final String courseLecturerMail; //student
  final String additionalMessage; //student
  final String courseID; //student
  final String courseWork; //student
  final String resource; //student
  final String project; //student
  final String examResult; //teacher

  const Skill(
      this.name,
      this.score,
      this.verifyStatus,
      this.courseName,
      this.courseLeaderMail,
      this.courseLecturerMail,
      this.additionalMessage,
      this.courseID,
      this.courseWork,
      this.resource,
      this.project,
      this.examResult);

  static Skill fromJson(Map<String, dynamic> json, String id) {
    Skill skill = Skill(
      json['name'],
      json['score'],
      json['verifyStatus'],
      json['courseName'],
      json['courseLeaderMail'],
      json['courseLecturerMail'],
      json['additionalMessage'],
      json['courseID'],
      json['courseWork'],
      json['resource'],
      json['project'],
      json['examResult'],
    );
    return skill;
  }

  static Skill fromSnapshot(Map<String, dynamic> snap, String id) {
    Skill skill = Skill(
      snap['name'],
      snap['score'],
      snap['verifyStatus'],
      snap['courseName'],
      snap['courseLeaderMail'],
      snap['courseLecturerMail'],
      snap['additionalMessage'],
      snap['courseID'],
      snap['courseWork'],
      snap['resource'],
      snap['project'],
      snap['examResult'],
    );
    return skill;
  }

  static skillToJson(Skill skill) {
    final data = {
      'name': skill.name,
      'score': skill.score,
      'verifyStatus': skill.verifyStatus,
      'courseName': skill.courseName,
      'courseLeaderMail': skill.courseLeaderMail,
      'courseLecturerMail': skill.courseLecturerMail,
      'additionalMessage': skill.additionalMessage,
      'courseID': skill.courseID,
      'courseWork': skill.courseWork,
      'resource': skill.resource,
      'project': skill.project,
      'examResult': skill.examResult,
    };
    return data;
  }

  @override
  List<Object?> get props => [
        name,
        score,
        verifyStatus,
        courseName,
        courseLeaderMail,
        courseLecturerMail,
        additionalMessage,
        courseID,
        courseWork,
        resource,
        project,
        examResult
      ];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'score': score,
      'verifyStatus': verifyStatus,
      'courseName': courseName,
      'courseLeaderMail': courseLeaderMail,
      'courseLecturerMail': courseLecturerMail,
      'additionalMessage': additionalMessage,
      'courseID': courseID,
      'courseWork': courseWork,
      'resource': resource,
      'project': project,
      'examResult': examResult,
    };
  }


}
