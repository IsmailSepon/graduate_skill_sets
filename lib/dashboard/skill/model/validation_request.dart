import 'package:equatable/equatable.dart';

class ValidationRequest extends Equatable { //teacher
  final String studentID; //student
  final String skillID; //student

  const ValidationRequest(
      this.studentID,
      this.skillID,);

  static ValidationRequest fromJson(Map<String, dynamic> json, String id) {
    ValidationRequest skill = ValidationRequest(
      json['studentID'],
      json['skillID'],
    );
    return skill;
  }

  @override
  List<Object?> get props => [studentID, skillID];

  // static ValidationRequest fromSnapshot(Map<String, dynamic> snap) {
  //   Skill skill = Skill(
  //     snap['name'],
  //     snap['score'],
  //     snap['verifyStatus'],
  //     snap['courseName'],
  //     snap['courseLeaderMail'],
  //     snap['courseLecturerMail'],
  //     snap['additionalMessage'],
  //     snap['courseID'],
  //     snap['courseWork'],
  //     snap['resource'],
  //     snap['project'],
  //     snap['examResult'],
  //     snap['courseLeaderName'],
  //   );
  //   return skill;
  // }
  //
  // static skillToJson(ValidationRequest validationRequest) {
  //   final data = {
  //     'name': skill.name,
  //     'score': skill.score,
  //     'verifyStatus': skill.verifyStatus,
  //     'courseName': skill.courseName,
  //     'courseLeaderMail': skill.courseLeaderMail,
  //     'courseLecturerMail': skill.courseLecturerMail,
  //     'additionalMessage': skill.additionalMessage,
  //     'courseID': skill.courseID,
  //     'courseWork': skill.courseWork,
  //     'resource': skill.resource,
  //     'project': skill.project,
  //     'examResult': skill.examResult,
  //     'courseLeaderName': skill.courseLeaderName,
  //   };
  //   return data;
  // }
  //
  // @override
  // List<Object?> get props => [
  //       name,
  //       score,
  //       verifyStatus,
  //       courseName,
  //       courseLeaderMail,
  //       courseLecturerMail,
  //       additionalMessage,
  //       courseID,
  //       courseWork,
  //       resource,
  //       project,
  //       examResult,
  //       courseLeaderName
  //     ];
  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'score': score,
  //     'verifyStatus': verifyStatus,
  //     'courseName': courseName,
  //     'courseLeaderMail': courseLeaderMail,
  //     'courseLecturerMail': courseLecturerMail,
  //     'additionalMessage': additionalMessage,
  //     'courseID': courseID,
  //     'courseWork': courseWork,
  //     'resource': resource,
  //     'project': project,
  //     'examResult': examResult,
  //     'courseLeaderName': courseLeaderName,
  //   };
  // }
  //

}
