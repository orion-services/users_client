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
import 'dart:io';
import 'package:orion_users_client/web_service.dart';
import 'package:prompts/prompts.dart' as prompts;

/// CLI client for Orion User micro service
class UsersCLI {
  // stores the host of user service
  String _host;

  // stores the port
  String _port;

  // enables security https or wss
  bool _security;

  // stores the token of a channel
  String _token;

  // stores a response of a operation
  String _response;

  // the User Web Service client
  UsersWebService _usersWebService;

  String _name;

  String _email;

  String _password;

  String _hash;

  String _id;

  String _nullString;

  // stores the jwt
  String _jwt;

  UsersCLI() {
    _host = 'localhost';
    _port = '8080';
    _token = '';
    _name = '';
    _email = '';
    _response = '';
    _id = '';
    _nullString = 'response: {"id":0}';

    // Setting the secure to false and development to true
    _security = false;
    _usersWebService = UsersWebService(_security);
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
    var options = [
      'Create user',
      'Login',
      'Configurations',
      'Exit'
    ];

    // configure the options
    var cli = prompts.choose('Options', options, defaultsTo: options[0]);

    // prints the menu
    print(cli);

    // executing actions according the options
    if (cli == options[0]) {
      await optionCreateUser();
    } else if (cli == options[1]) {
      await optionLogin();
    } else if (cli == options[2]) {
      await optionConfigure();
    } else if (cli == options[3]) {
      loop = false;
      clear();
    }
    return Future.value(loop);
  }

  /// Executes the menu option to create a new channel
  void optionLogin() async {
    try {
      clear();
      askEmail();
      askPassword();

      var response = await _usersWebService.login(_email, _password);
      _jwt = response.body;
      _response = '${_jwt}';
    } on Exception {
      _response = 'Connection refused';
    }
  }

  //Client create a user
  void optionCreateUser() async {
    clear();
    try {
      askName();
      askEmail();
      askPassword();

      var response =
          await _usersWebService.createUser(_name, _email, _password);

      if (response.statusCode == 400) {
        _response = 'response: ${response.statusCode}';
      } else {
        _response = 'response: ${response.body}';
      }
    } on Exception {
      _response = 'error';
    }
  }

  //Retrieve a user, with email and password
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
    } on Exception {
      _response = 'error';
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
    } on Exception {
      _response = 'error';
    }
  }

  //Update a user
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
    } on Exception {
      _response = 'error';
    }
  }

  //Delete a user
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
    } on Exception {
      _response = 'error';
    }
  }

  //List a user
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
    } on Exception {
      _response = 'error';
    }
  }

  /// Executes the menu option do configure host and port of the server
  void optionConfigure() {
    askHost();
    askPort();
    askSecurity();

    _usersWebService.changeServiceURL(_security, _host, _port);

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
