import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:branch_example/login/models/login_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:branch_example/login/models/login_model.dart';
import 'package:branch_example/login/services/login_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepo repository;

  LoginBloc({@required this.repository}) : super(LoginInitialState());

  // TODO: implement initialState
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is send_login) {
      yield LoginSendingState();
      try {
        login_model result =
            await LoginRepoImp.signin(event.name, event.password);
        yield LoginResponseState(result: result);
      } catch (e) {
        yield LoginErrorState(error: e);
      }
    } else if (event is InitialEvent) {
      yield LoginInitialState();
    }
    // TODO: implement mapEventToState
  }
}
