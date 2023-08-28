import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/auth_repository.dart';
import 'auth_state.dart';

class GPAuthCubit extends Cubit<AuthState> {




  final AuthRepository repository;
   GPAuthCubit( {required this.repository}) : super(AuthInitial());
   Future<void> register(String email, String password) async {
     // repository.registerWithEmailAndPassword(email, password);
      repository.getUniversityList();
     // repository.signInWithMicrosoft();


     //repository.addUniversity();
   }


  Future<void> login(String email, String password) async {
    // emit(state.copyWith(status: AuthStatus.loading));
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