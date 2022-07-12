/// Copyright 2022 Orion Services @ https://github.com/orion-services
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
/// http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
///  limitations under the License.

// ignore_for_file: await_only_futures
import 'dart:io';
import 'package:http/http.dart';
import 'package:users_client/client/user_ws.dart';
import 'package:prompts/prompts.dart' as prompts;
import 'package:users_client/uc/user_uc_interface.dart';
import 'package:users_client/uc/user_uc.dart';

/// CLI client for Orion User micro service
class UsersCLI {
  // stores the host of user service
  String _host = 'localhost';

  // stores the port
  String _port = '8080';

  // enables security https
  bool _security = false;

  // stores a response of a operation
  String _response = '';

  String _name = '';

  String _email = '';

  String _password = '';

  String _hash = '';

  String _id = '';

  // the User Web Service client
  late UsersWebService _usersWebService;

  // Use cases
  late UserUCInterface _userUC;

  // stores the jwt
  late String _jwt;

  UsersCLI() {
    _usersWebService = UsersWebService();
    _userUC = UserUC();
  }

  // Prints the menu
  Future<bool> menu() async {
    // clear console
    clear();

    // print the response of last operation
    print(_response);

    // controls the loop of the main menu
    var loop = true;

    // the main menu options
    var options = ['Create user', 'Login', 'Configurations', 'Exit'];

    // configure the options
    var cli = prompts.choose('Options', options, defaultsTo: options[0]);

    // prints the menu
    print(cli);

    try {
      // executing actions according the options
      if (cli == options[0]) {
        await optionCreateUser();
      } else if (cli == options[1]) {
        await optionLogin();
      } else if (cli == options[2]) {
        optionConfigure();
      } else if (cli == options[3]) {
        loop = false;
        clear();
      }
    } catch (e) {
      print(e);
    }

    return Future.value(loop);
  }

  /// Create a user
  Future<Response> optionCreateUser() async {
    clear();
    try {
      askName();
      askEmail();
      askPassword();

      var response = await _userUC.createUser(_name, _email, _password);

      if (response.statusCode == 400) {
        _response = 'response: ${response.statusCode}';
      } else {
        _response = 'response: ${response.body}';
      }
      return response;
    } catch (e) {
      _response = e.toString();
      throw ('createUser');
    }
  }

  /// Executes the menu option to create a new channel
  Future<Response> optionLogin() async {
    try {
      clear();
      askEmail();
      askPassword();

      var response = await _userUC.login(_email, _password);
      _jwt = response.body;
      _response = '$_jwt';
      return response;
    } catch (e) {
      _response = e.toString();
      throw ('login');
    }
  }

  /// Retrieve a user, with email and password
  void optionForgotRetrieveUser() async {
    clear();

    try {
      askEmail();
      var response = await _usersWebService.forgotUser(_email);

      if (response.statusCode == 409) {
        _response = 'response: ${response.statusCode}';
      } else {
        _response = 'response: ${response.body}';
      }
    } catch (e) {
      _response = e.toString();
      throw ('forgotUser');
    }

    try {
      askHash();
      askPassword();
      var response = await _usersWebService.retrieveUser(_hash, _password);

      if (response.statusCode == 409) {
        _response = 'response: ${response.statusCode}';
      } else {
        _response = 'response: ${response.body}';
      }
    } catch (e) {
      _response = e.toString();
      throw ('retrieveUser');
    }
  }

  /// Update a user
  void optionUpdateUser() async {
    clear();
    try {
      askId();
      askName();
      askEmail();
      askPassword();
      var response = await _usersWebService.updateUser(
          _id, _name, _email, _password, _jwt);

      if (response.statusCode == 409) {
        _response = 'response: ${response.statusCode}';
      } else {
        _response = 'response: ${response.body}';
      }
    } catch (e) {
      _response = e.toString();
      throw ('updateUser');
    }
  }

  /// Delete a user
  void optionDeleteUser() async {
    clear();
    try {
      askId();
      var response = await _usersWebService.deleteUser(_id, _jwt);

      if (response.statusCode == 409) {
        _response = 'response: ${response.statusCode}';
      } else {
        _response = 'response: ${response.body}';
      }
    } catch (e) {
      _response = e.toString();
      throw ('deleteUser');
    }
  }

  /// List a user
  void optionListUser() async {
    clear();
    try {
      askId();
      var response = await _usersWebService.listUser(_id, _jwt);

      if (response.statusCode == 409) {
        _response = 'response: ${response.statusCode}';
      } else {
        _response = 'response: ${response.body}';
      }
    } catch (e) {
      _response = e.toString();
      throw ('listUser');
    }
  }

  /// Executes the menu option do configure host and port of the server
  void optionConfigure() {
    askHost();
    askPort();
    askSecurity();

    _usersWebService.changeServiceConnection(_security, _host, _port);

    _response = 'Service URL: ' + _usersWebService.wsURL;
  }

  /// clear the console
  void clear() {
    if (Platform.isWindows) {
      // We need to test it on Windows
      print(Process.runSync('cls', [], runInShell: true).stdout);
    } else {
      print(Process.runSync('clear', [], runInShell: true).stdout);
    }
  }

  /// ask about service host
  void askHost() {
    _host = prompts.get('Host: ', defaultsTo: _host);
  }

  /// ask about service port
  void askPort() {
    _port = prompts.get('Port: ', defaultsTo: _port);
  }

  /// ask about service security (http or https)
  void askSecurity() {
    _security = prompts.getBool('Enable https: ', defaultsTo: _security);
  }

  /// ask about the user's e-mail
  void askEmail() {
    _email = prompts.get('E-mail: ', defaultsTo: _email);
  }

  void askHash() {
    _hash = prompts.get('Hash: ', defaultsTo: _hash);
  }

  /// ask about the user's password
  void askPassword() {
    _password = prompts.get('Password: ', defaultsTo: _password);
  }

  /// ask about the user's name
  void askName() {
    _name = prompts.get('Name: ', defaultsTo: _name);
  }

  /// ask about the ID's name
  void askId() {
    _id = prompts.get('ID: ', defaultsTo: _id);
  }
}
