import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class BaseState<Type> extends Equatable{
  final bool isLoading;


  const BaseState(this.isLoading);

  Type copyWith({required bool isLoading});

  List get additionalProps;

  @override
  @nonVirtual
  List<Object?> get props => [isLoading, ...additionalProps];

}