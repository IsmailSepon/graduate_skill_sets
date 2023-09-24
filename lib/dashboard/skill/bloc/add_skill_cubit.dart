import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:go_router/go_router.dart';
import 'package:gp/dashboard/skill/bloc/add_skill_details_state.dart';
import 'package:gp/firebaseDynamicLink/firebase_fynamic_link_service.dart';
import 'package:gp/firestore/firestore_services.dart';

import '../../dashboard.dart';
import '../model/validation_request.dart';

class AddSkillDetailsCubit extends Cubit<AddSkillDetailsState> {
  AddSkillDetailsCubit(super.initialState);

  void updateSinglePropertyOnState(String key, dynamic value) {
    emit(state.copySingleProperty(key, value));
  }

  Future<void> sendValidationRequest(
      BuildContext context, String skillID) async {
    // final uid = FirebaseAuth.instance.currentUser!.uid;
    emit(state.copySingleProperty('isLoading', true));



    var validation = ValidationRequest(
      FirebaseAuth.instance.currentUser!.uid,
      skillID,
    );
     await FirebaseDynamicLinkService.generateValidationRequest(validation).then(
        (validationLink) =>
            sendEmailToCourseLeader(context, skillID, validationLink));
  }

  sendEmailToCourseLeader(
      BuildContext context, String skillID, String validationLink) async {
    if (validationLink.isEmpty || skillID.isEmpty) {
      showErrorDialog(context, 'Information Missing', 'Please try again later');
    } else {
      final Email email = Email(
        body:
            'test Email from student ${FirebaseAuth.instance.currentUser?.displayName}  \n Please Click this and Validate you student: \n$validationLink',
        subject:
            'Request for Skill validation from ${FirebaseAuth.instance.currentUser?.displayName}',
        recipients: [(state.courseLeaderMail)],
        cc: [(state.courseLecturerMail)],
        isHTML: false,
      );


      String skillName = FireStoreService().getSkillName(skillID);

      bool status = FireStoreService().sendValidation(
          state.courseName,
          state.courseLeaderMail,
          state.courseLecturerMail,
          state.additionalMessage,
          state.courseWork,
          state.project,
          state.courseLeaderName, skillName);


      if (status) {

        await FlutterEmailSender.send(email);
        // context.go('/');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  Dashboard()));
      }else{
        showErrorDialog(context, 'Problem', 'there was a problem sending the request, please try again later');
      }
    }
  }

  showErrorDialog(BuildContext context, String title, String message) {
    AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.error,
      showCloseIcon: true,
      title: title,
      desc: message,
      btnOkOnPress: () {
        // context.go('/');

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  Dashboard()));

      },
      btnOkIcon: Icons.check_circle,
      onDismissCallback: (type) {},
    ).show();
  }
}
