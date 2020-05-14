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
import 'package:orion_talk_client/web_service.dart';
import 'package:prompts/prompts.dart' as prompts;

/// CLI client for Orion Talk micro service
class TalkCLI {
  // stores the host of talk service
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

  // the Talk Web Service client
  TalkWebService _talkWebService;

  TalkCLI() {
    _host = 'localhost';
    _port = '9081';
    _token = '';
    _response = '';

    // Seting the secure to false and development to true
    _security = false;
    _devMode = true;
    _talkWebService = TalkWebService(_security, _devMode);
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
      'Create channel',
      'Send message to a channel',
      'Load messages',
      'Configurations',
      'Exit'
    ];

    // configure the options
    var cli = prompts.choose('Options', options, defaultsTo: options[0]);

    // prints the menu
    print(cli);

    // executing actions according the options
    if (cli == options[0]) {
      // create channel
      await optionCreateChannel();
    } else if (cli == options[1]) {
      // send message
      await optionSendMessage();
    } else if (cli == options[2]) {
      // load messages
      await optionLoadMessages();
    } else if (cli == options[3]) {
      // Configure
      optionConfigure();
    } else if (cli == options[4]) {
      loop = false;
      clear();
    }
    return Future.value(loop);
  }

  /// Executes the menu option to create a new channel
  void optionCreateChannel() async {
    try {
      var response = await _talkWebService.createChannel();
      _token = json.decode(response.body)['token'];
      _response = 'Create channel response: ${response.body}';
    } on Exception {
      _response = 'Connection refused';
    }
  }

  /// Executes the menu option to send a message do the service
  void optionSendMessage() async {
    clear();
    try {
      questionToken();
      var textMessage = questionTextMessage();
      var response = await _talkWebService.sendTextMessage(textMessage);
      _response = 'Send message response: ${response.body}';
    } on Exception {
      _response = 'Connection refused';
    }
  }

  /// Executes the menu option to send a message do the service
  void optionLoadMessages() async {
    clear();
    try {
      questionToken();
      var response = await _talkWebService.loadMessages(_token);
      _response = 'Load message responde: ${response.body}';
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

    _talkWebService.changeServiceURL(_security, _devMode, _host, _port);

    _response = 'Web Service URL: ' + _talkWebService.wsURL;
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

  /// ask about the token of a channel
  void questionToken() {
    _token = prompts.get('Token of a channel: ', defaultsTo: _token);

    // stores the token in the Web Service
    _talkWebService.token = _token;
  }

  /// ask about the message to send to a channel
  String questionTextMessage() {
    return prompts.get('Messsage: ');
  }
}
