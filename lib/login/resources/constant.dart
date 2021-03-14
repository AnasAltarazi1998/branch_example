import 'package:flutter/cupertino.dart';

class LoginConst {
  // ignore: non_constant_identifier_names
  static String login_url({@required String name, @required String password}) {
    return "http://syberctf.hadara-group.com:8080/users/signin/" +
        name +
        "/" +
        password;
  }
}
