import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/university_model.dart';
import '../repo/auth_repository.dart';
import 'auth_state.dart';

class GPAuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  GPAuthCubit({required this.repository}) : super(AuthState.initial());

  void updateSinglePropertyOnState(String key, dynamic value) {
    emit(state.copySingleProperty(key, value));
    // emit(state.copyWith(name: value));
  }

  Future<void> register() async {
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
      //go for dashboard
    } else {
      emit(state.copySingleProperty('isLoading', false));
    }


  }

  Future<void> login() async {

    emit(state.copySingleProperty('isLoading', true));
    bool status = await repository.login(state.email, state.password);
    //emit(state.copyWith(status: AuthStatus.loading));
    // try {
    //   final user = await AuthRepository.login(email, password);
    //   emit(state.copyWith(user: user, status: AuthStatus.authenticated));
    // } on Exception catch (e) {
    //   emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    // }
  }

  Future<void> logout() async {
    // emit(state.copyWith(status: AuthStatus.loading));
    // try {
    //   await AuthRepository.logout();
    //   emit(state.copyWith(user: null, status: AuthStatus.unauthenticated));
    // } on Exception catch (e) {
    //   emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    // }
  }
}
