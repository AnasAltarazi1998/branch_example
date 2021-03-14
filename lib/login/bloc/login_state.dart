part of 'login_bloc.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSendingState extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => throw [];
}

class LoginResponseState extends LoginState {
  login_model result;
  LoginResponseState({@required this.result});
  @override
  // TODO: implement props
  List<Object> get props => [result];
}

class LoginErrorState extends LoginState {
  String error;
  LoginErrorState({@required this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
