/// Copyright 2020 Orion Services
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
import 'dart:convert';
import 'package:orion_users_client/web_service.dart';
import 'package:prompts/prompts.dart' as prompts;

/// CLI client for Orion User micro service
class UserCLI {
  // stores the host of user service
  String _host;

  // stores the port
  String _port;

  // enable development mode
  bool _devMode;

  // enables security https or wss
  bool _security;

  // stores the token of a channel
  String _token;

  // stores a response of a operation
  String _response;

  // the User Web Service client
  UserWebService _userWebService;

  String _name;

  String _email;

  String _id;

  UserCLI() {
    _host = 'localhost';
    _port = '9081';
    _token = '';
    _name = '';
    _email = '';
    _response = '';
    _id = '';

    // Seting the secure to false and development to true
    _security = false;
    _devMode = true;
    _userWebService = UserWebService(_security, _devMode);
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
      'Update user',
      'Delete user',
      'List user',
      'Configurations',
      'Exit'
    ];

    // configure the options
    var cli = prompts.choose('Options', options, defaultsTo: options[0]);

    // prints the menu
    print(cli);

    // executing actions according the options
    if (cli == options[0]) {
      // create user
      await optionCreateUser();
    } else if (cli == options[1]) {
      // update user
      await optionUpdateUser();
   }  else if (cli == options[2]) {
      // delete user
      await optionDeleteUser();
   }  else if (cli == options[3]) {
      // list users
      await optionListUser();
    } else if (cli == options[4]) {
      // Configure
      optionConfigure();
    } else if (cli == options[5]) {
      loop = false;
      clear();
    }
    return Future.value(loop);
  }

void optionCreateUser() async{
    clear();
    try {
      // questionName();
      // questionEmail();
     _name = prompts.get('name of a user: ', defaultsTo: _name);
     _email = prompts.get('name of a email: ', defaultsTo: _email);
      var response = await _userWebService.createUser(_name,_email);
      _response = 'response: ${response.body}';
    } on Exception {
      _response = 'Connection refused';
    }
  }

  void optionUpdateUser() async{
    clear();
    try {
     _id = prompts.get('your id: ', defaultsTo: _id);
     _name = prompts.get('name of a user: ', defaultsTo: _name);
     _email = prompts.get('name of a email: ', defaultsTo: _email);
      var response = await _userWebService.updateUser(_id, _name,_email);
      
      _response = 'response: ${response.body}';
    } on Exception {
      _response = 'Connection refused';
    }
  }

   void optionDeleteUser() async{
    clear();
    try {
     _id = prompts.get('your id: ', defaultsTo: _id);
      var response = await _userWebService.deleteUser(_id);
      
      _response = 'response: ${response.body}';
    } on Exception {
      _response = 'Connection refused';
    }
  }

     void optionListUser() async{
    clear();
    try {
     _id = prompts.get('your id: ', defaultsTo: _id);
      var response = await _userWebService.listUser(_id);
      
      _response = 'response: ${response.body}';
    } on Exception {
      _response = 'Connection refused';
    }
  }



  /// Executes the menu option do configure host and port of the server
  void optionConfigure() {
      questionHost();
      questionPort();
      questionSecurity();
      questionDevMode();

    _userWebService.changeServiceURL(_security, _devMode, _host, _port);

    _response = 'Web Service URL: ' + _userWebService.wsURL;
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
  void questionHost() {
    _host = prompts.get('Host: ', defaultsTo: _host);
  }

  /// ask about service port
  void questionPort() {
    _port = prompts.get('Port: ', defaultsTo: _port);
  }

  /// ask about service security (http or https)
  void questionSecurity() {
    _security = prompts.getBool('Enable security: ', defaultsTo: _security);
  }

  /// enables dev mode
  void questionDevMode() {
    _devMode = prompts.getBool('Enable devmode: ', defaultsTo: _devMode);
  }

  //  void questionName() {
  //     _name = prompts.get('name of a user: ', defaultsTo: _name);

  //   }
  //   void questionEmail() {
  //     _email = prompts.get('name of a email: ', defaultsTo: _email);

  //   }
    

}
