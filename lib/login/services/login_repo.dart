import 'dart:convert';

import 'package:branch_example/login/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:branch_example/login/resources/constant.dart';

abstract class LoginRepo {
  // ignore: non_constant_identifier_names
  static Future<login_model> signin(String name, String password) {}
}

class LoginRepoImp extends LoginRepo {
  @override
  static Future<login_model> signin(String name, String password) async {
    var response =
        await http.get(LoginConst.login_url(name: name, password: password));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      login_model res = login_model.fromJson(data);
      return res;
    } else {
      return login_model(id: -1, name: response.statusCode.toString());
    }
  }
}
