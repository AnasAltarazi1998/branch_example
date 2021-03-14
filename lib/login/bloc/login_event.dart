part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class send_login extends LoginEvent {
  String name;
  String password;
  send_login({@required this.name, @required this.password});
  @override
  List<Object> get props => null;
}

class InitialEvent extends LoginEvent {
  @override
  List<Object> get props => null;
}
