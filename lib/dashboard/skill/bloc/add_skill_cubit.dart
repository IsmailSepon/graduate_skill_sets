import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/dashboard/skill/bloc/add_skill_details_state.dart';
import 'package:gp/firestore/firestore_services.dart';

class AddSkillDetailsCubit extends Cubit<AddSkillDetailsState> {
  AddSkillDetailsCubit(super.initialState);


  void updateSinglePropertyOnState(String key, dynamic value) {
    emit(state.copySingleProperty(key, value));
  }

  Future<void> sendValidationRequest() async{
    // final uid = FirebaseAuth.instance.currentUser!.uid;
    emit(state.copySingleProperty('isLoading', true));
    var status = FireStoreService().sendValidation(state.courseName, state.courseLeaderMail, state.courseLecturerMail, state.additionalMessage, state.courseWork, state.project);


    if(status ==true){

    }

  }

}