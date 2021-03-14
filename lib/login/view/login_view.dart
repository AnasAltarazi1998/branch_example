import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:branch_example/login/bloc/login_bloc.dart';
import 'package:get/get.dart';
import 'package:branch_example/login/services/login_repo.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginView());
  }

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginBloc _loginBloc;
  _onLoginButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(
      send_login(
        name: nameController.text,
        password: passwordController.text,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _loginBloc.add(InitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sample App'),
        ),
        body: BlocListener<LoginBloc, LoginState>(listener: (context, state) {
          if (state is LoginResponseState) {
            // // if (state.result.id > -1)
            // //   // Get.to(() => home_page());
            // else
            Get.snackbar("error", state.result.name);
          } else if (state is LoginErrorState) {
            Get.snackbar("error", state.error);
            _loginBloc.add(InitialEvent());
          }
        }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          if (state is LoginInitialState)
            return formui();
          else if (state is LoginSendingState)
            return Center(child: CircularProgressIndicator());
          else if (state is LoginErrorState) return Text(state.error);
          return formui();
        })));
  }

  Widget formui() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'TutorialKart',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                    fontSize: 30),
              )),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'Sign in',
                style: TextStyle(fontSize: 20),
              )),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              //forgot password screen
            },
            child: Text('Forgot Password'),
          ),
          Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: Text('Login'),
                onPressed: () {
                  _onLoginButtonPressed();
                },
              )),
          Container(
              child: Row(
            children: <Widget>[
              Text('Does not have account?'),
              TextButton(
                child: Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () => _onLoginButtonPressed,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ))
        ],
      ),
    );
  }
}
