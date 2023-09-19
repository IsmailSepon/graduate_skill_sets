
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/auth/model/student_auth_mode/student_auth_model.dart';
import 'package:gp/dashboard/profile/bloc/profile_state.dart';
import '../../../firestore/firestore_services.dart';

class ProfileCubit extends Cubit<ProfileState> {

  final String? studentID;


  ProfileCubit({required this.studentID}): super(ProfileState.initial()){
    fetchStudentSkillData(studentID!);
  }

  void updateSinglePropertyOnState(String key, dynamic value) {
    emit(state.copySingleProperty(key, value));
    // emit(state.copyWith(name: value));
  }

  Future<void> fetchStudentSkillData(String studentID) async {
    FireStoreService fireStoreService = FireStoreService();
    StudentAuthModel studentAuthModel = await fireStoreService.getStudentDetails(studentID);
    if(studentAuthModel != StudentAuthModel.empty){
      emit(state.copySingleProperty('student', studentAuthModel));
    }else{

    }


  }


}

