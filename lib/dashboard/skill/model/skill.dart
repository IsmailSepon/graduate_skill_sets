import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Skill extends Equatable {
  final String name; //by student
  final double score; // teacher
  final bool verifyStatus; //teacher
  final String courseName; //student
  final String courseLeaderMail; //student
  final String courseLeaderName; //student
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
      this.examResult, this.courseLeaderName);

  static Skill get empty => const Skill('', 0, false, '', '', '', '', '', '', '', '', '', '');

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
      json['courseLeaderName'],
    );
    print('skill request: $skill');
    return skill;
  }

  static Skill fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
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
      snap['courseLeaderName'],
    );
    print('skill request: $skill');
    return skill;
  }
  static Skill fromSnapshot(Map<String, dynamic> snap) {
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
      snap['courseLeaderName'],
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
      'courseLeaderName': skill.courseLeaderName,
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
        examResult,
        courseLeaderName
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
      'courseLeaderName': courseLeaderName,
    };
  }


}
