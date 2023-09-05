import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:go_router/go_router.dart';
import 'package:gp/dashboard/skill/bloc/add_skill_details_state.dart';
import 'package:gp/firestore/firestore_services.dart';

class AddSkillDetailsCubit extends Cubit<AddSkillDetailsState> {
  AddSkillDetailsCubit(super.initialState);

  void updateSinglePropertyOnState(String key, dynamic value) {
    emit(state.copySingleProperty(key, value));
  }

  Future<void> sendValidationRequest(BuildContext context) async {
    // final uid = FirebaseAuth.instance.currentUser!.uid;
    emit(state.copySingleProperty('isLoading', true));
    await FireStoreService().sendValidation(
        state.courseName,
        state.courseLeaderMail,
        state.courseLecturerMail,
        state.additionalMessage,
        state.courseWork,
        state.project
        , state.courseLeaderName);

    await sendEmailToCourseLeader();


    context.go('/');
  }

  sendEmailToCourseLeader() async {

    final Email email = Email(
      body: 'test Email from student ${FirebaseAuth.instance.currentUser?.displayName}',
      subject: 'Request for Skill validation from ${FirebaseAuth.instance.currentUser?.displayName}',
      recipients: [(state.courseLeaderMail)],
      cc: [(state.courseLecturerMail)],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);

  }
}
