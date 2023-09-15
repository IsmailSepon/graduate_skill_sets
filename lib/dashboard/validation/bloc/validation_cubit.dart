
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/dashboard/validation/bloc/validation_state.dart';
import '../../../firestore/firestore_services.dart';
import '../../skill/model/skill.dart';
import '../model/student.dart';

class ValidationCubit extends Cubit<ValidationState> {

  final String? skillID;
  final String? studentID;


  ValidationCubit({required this.skillID, required this.studentID}): super(ValidationState.initial()){
    fetchStudentSkillData(studentID!, skillID!);
  }

  void updateSinglePropertyOnState(String key, dynamic value) {
    emit(state.copySingleProperty(key, value));
    // emit(state.copyWith(name: value));
  }

  Future<void> fetchStudentSkillData(String studentID, String skillID) async {

    FireStoreService fireStoreService = FireStoreService();
    fireStoreService.getStudentDetails(studentID);

    Student student = await fireStoreService.getStudentDetails(studentID);
    emit(state.copySingleProperty('student', student));
       print('student name: ${student.name}');

    Skill skill = await  fireStoreService.getSkillDetails(studentID, skillID);
    emit(state.copySingleProperty('skill', skill));
       print('skill details name: ${skill.name}');

  }

}

