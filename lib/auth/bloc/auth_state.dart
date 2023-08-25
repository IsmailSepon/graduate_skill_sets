import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class Registration extends AuthState {
  @override
  List<Object> get props => [];
}

class Login extends AuthState {
  @override
  List<Object> get props => [];
}

