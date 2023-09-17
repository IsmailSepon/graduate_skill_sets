
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

  void updateTheRating(BuildContext context) async{
    emit(state.copySingleProperty('isLoading', true));
    FireStoreService fireStoreService = FireStoreService();
    await fireStoreService.updateSkillRating(studentID!, skillID!, double.parse(state.rating));


    AwesomeDialog(
          context: context,
          animType: AnimType.leftSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: true,
          title: 'Succes',
          btnOkOnPress: () {
            context.go('/login');
          },
          btnOkIcon: Icons.check_circle,
          onDismissCallback: (type) {
            debugPrint('Dialog Dissmiss from callback $type');
          },
        ).show();

    print('Updated score');
  }





}

