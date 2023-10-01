import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gp/dashboard/dashboard.dart';
import 'package:gp/teacher_dashboard/teacher_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repo/auth_repository.dart';
import 'auth_state.dart';

class GPAuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  GPAuthCubit({required this.repository}) : super(AuthState.initial());

  void updateSinglePropertyOnState(String key, dynamic value) {
    emit(state.copySingleProperty(key, value));
    // emit(state.copyWith(name: value));
  }

  Future<void> register(BuildContext context) async {
    emit(state.copySingleProperty('isLoading', true));
    bool status = await repository.registerWithEmailAndPassword(
        state.email,
        state.password,
        state.university,
        state.department,
        state.studentId,
        state.dateOfBirth,
        state.name);

    if (status) {
      emit(state.copySingleProperty('isLoading', false));
      context.go('/');
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Dashboard()));
      //go for dashboard
    } else {
      emit(state.copySingleProperty('isLoading', false));
      showErrorDialog(context, 'Registrtation Error', 'Please try again later');
    }


  }

   teacherRegister(BuildContext context) async {
    emit(state.copySingleProperty('isLoading', true));
    bool status = await repository.teacherRegisterWithEmailAndPassword(
        state.email,
        state.password,
        state.university,
        state.department, state.name);

    if (status) {
      emit(state.copySingleProperty('isLoading', false));
      //context.go('/');

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Dashboard()));
      //go for dashboard
    } else {
      emit(state.copySingleProperty('isLoading', false));
      showErrorDialog(context, 'Registrtation Error', 'Please try again later');
    }


  }


  Future<void> login(BuildContext context, int role) async {
    emit(state.copySingleProperty('isLoading', true));
    User? user = await repository.login(state.email, state.password);

    if (user != null && user.email != null) {
      emit(state.copySingleProperty('isLoading', false));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      //go for dashboard
      if(role ==0){
        prefs.setInt('role', 0);
        // Navigator.pushReplacement(
        //    context,MaterialPageRoute(builder: (context) => const Dashboard()),);
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  Dashboard()));
        //context.go('/');
      }else{

        prefs.setInt('role', 1);
        // context.go('/teacherDashboard');
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TeacherDashBoard()));
      }
    } else {
      showErrorDialog(context, 'Login Error', 'Please check your mail & password');
      emit(state.copySingleProperty('isLoading', false));
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

      },
      btnOkIcon: Icons.check_circle,
      onDismissCallback: (type) {
      },
    ).show();
  }
}
