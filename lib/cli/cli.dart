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
import 'package:yaml/yaml.dart';
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
    var version = await readVersion();
    print('Users CLI ' + version);

    // print the response of last operation
    print(_response);

    // controls the loop of the main menu
    var loop = true;

    // the main menu options
    var options = [
      'Create user',
      'Authenticate',
      'Create and Authenticate',
      'Recover Password',
      'Update E-mail',
      'Update Password',
      'Configure',
      'Exit'
    ];

    var cli = prompts.choose('Menu', options, defaultsTo: options[0]);

    // printing the menu
    print(cli);

    try {
      // executing actions according the options
      if (cli == options[0]) {
        await optionCreateUser();
      } else if (cli == options[1]) {
        await optionAuthenticate();
      } else if (cli == options[2]) {
        await optionCreateAuthenticate();
      } else if (cli == options[3]) {
        await optionRecoverPassword();
      } else if (cli == options[4]) {
        await optionUpdateEmail();
      } else if (cli == options[5]) {
        await optionUpdatePassword();
      } else if (cli == options[6]) {
        optionConfigure();
      } else if (cli == options[7]) {
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
    print('Create User:');
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
  Future<Response> optionAuthenticate() async {
    clear();
    print('Authenticate:');
    try {
      askEmail();
      askPassword();

      var response = await _userUC.authenticate(_email, _password);
      _jwt = response.body;
      _response = '$_jwt';
      return response;
    } catch (e) {
      _response = e.toString();
      throw ('authenticate');
    }
  }

  /// Creates and authenticates a user
  Future<Response> optionCreateAuthenticate() async {
    clear();
    print('Create and Authenticate:');
    try {
      askName();
      askEmail();
      askPassword();

      var response = await _userUC.createAuthenticate(_name, _email, _password);

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

  /// Send a email to your email address containing the new password
  Future<Response> optionRecoverPassword() async {
    clear();
    print('Recovery Password:');
    try {
      askEmail();

      var response = await _userUC.recoverPassword(_email);

      if (response.statusCode == 400) {
        _response = 'response: ${response.statusCode}';
      } else {
        // returns 204 (no content) if ok
        _response = 'response: ${response.statusCode}';
      }
      return response;
    } catch (e) {
      _response = e.toString();
      throw ('recoverPassword');
    }
  }

  /// Changes the e-mail of a user
  Future<Response> optionUpdateEmail() async {
    clear();
    print('Update E-mail:');
    try {
      askJWT();
      askEmail();
      var newEmail = prompts.get('New e-mail: ', defaultsTo: '');

      var response = await _userUC.updateEmail(_email, newEmail, _jwt);
      if (response.statusCode == 400) {
        _response = 'response: ${response.statusCode}';
        return response;
      } else {
        _email = newEmail;
        _jwt = response.body;
        _response = 'response: ${response.body}';
        return response;
      }
    } catch (e) {
      _response = e.toString();
      throw ('updateEmail');
    }
  }

  /// Update the password of a user
  Future<Response> optionUpdatePassword() async {
    clear();
    print('Update Password:');
    try {
      askJWT();
      askEmail();
      askPassword();
      var newPassword = prompts.get('new password: ', defaultsTo: '');

      var response =
          await _userUC.updatePassword(_email, _password, newPassword, _jwt);

      print(response.statusCode);

      if (response.statusCode == 400) {
        _response = 'response: ${response.statusCode}';
      } else {
        _password = newPassword;
        _response = 'response: ${response.body}';
      }
      return response;
    } catch (e) {
      _response = e.toString();
      throw ('recoverPassword');
    }
  }

  /// Executes the menu option do configure host and port of the server
  void optionConfigure() {
    print('Configure:');
    askHost();
    askPort();
    askSecurity();

    _usersWebService.changeServiceConnection(_security, _host, _port);
    _response = 'Users endpoint: ' + _usersWebService.wsURL;
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

  /// ask about jwt
  void askJWT() {
    _jwt = prompts.get('JWT-: ', defaultsTo: _jwt);
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

  /// Reads pubspec version
  Future<String> readVersion() async {
    try {
      final file = await File('pubspec.yaml');
      final contents = await file.readAsString();
      Map yaml = loadYaml(contents);
      return yaml['version'];
    } catch (e) {
      return 'Error to read the pubspec file';
    }
  }
}
