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
import 'package:orion_talk_client/service_client.dart';
import 'package:prompts/prompts.dart' as prompts;

/// CLI client for Orion Talk micro service
class TalkCLI {
  String _host;
  String _port;
  String _token;
  TalkWebServiceClient _talk;

  TalkCLI() {
    _host = 'localhost';
    _port = '9081';
    _token = '';
    // Seting the secure to false and development to true
    _talk = TalkWebServiceClient(false, true);
  }

  // Prints the menu
  Future<bool> menu() async {
    // controls the loop of the main menu
    var loop = true;

    // the main menu options
    var options = [
      'Configure host and port',
      'Create channel',
      'Send message to a channel',
      'Load Messages',
      'Web socket connect',
      'Web socket send message',
      'Clear console',
      'Exit'
    ];

    // configure the options
    var cli = prompts.choose('Options', options, defaultsTo: options[0]);
    // prints the menu
    print(cli);

    // executing actions according the options
    if (cli == options[0]) {
      // Configure
      optionConfigure();
    } else if (cli == options[1]) {
      // create channel
      await optionCreateChannel();
    } else if (cli == options[2]) {
      // send message
      await optionSendMessage();
    } else if (cli == options[3]) {
      // load messages
      await optionLoadMessages();
    } else if (cli == options[4]) {
      await optionWebSocketConnect();
    } else if (cli == options[5]) {
      await optionWebSocketSend();
    } else if (cli == options[6]) {
      clear();
    } else if (cli == options[7]) {
      loop = false;
      clear();
    }
    return Future.value(loop);
  }

  /// Executes the menu option do configure host and port of the server
  void optionConfigure() {
    questionHost();
    questionPort();

    // set talk client
    _talk.host = _host;
    _talk.port = _port;
  }

  /// Executes the menu option to create a new channel
  Future<void> optionCreateChannel() async {
    var response = await _talk.createChannel();
    _token = json.decode(response.body)['token'];
    print('${response.body}');
  }

  /// Executes the menu option to send a message do the service
  Future<void> optionSendMessage() async {
    questionToken();
    var textMessage = questionTextMessage();
    var response = await _talk.sendTextMessage(textMessage);
    print('${response.body}');
  }

  /// Executes the menu option to send a message do the service
  Future<void> optionLoadMessages() async {
    questionToken();
    var response = await _talk.loadMessages(_token);
    print('${response.body}');
  }

  // Executes the menu option to create a
  Future<void> optionWebSocketConnect() async {
    questionToken();
    //await _talk.connect(_token, onMessage);
    print('Connected to the channel: ' + _token);
  }

  // Executes the menu option to create a
  Future<void> optionWebSocketSend() async {
    var message = questionTextMessage();
    // await _talk.send(message);
  }

  void onMessage(message) {
    print(message);
  }

  void questionHost() {
    _host = prompts.get('Host: ', defaultsTo: _host);
  }

  void questionPort() {
    _port = prompts.get('Port: ', defaultsTo: _port);
  }

  void questionToken() {
    _token = prompts.get('Token of a channel: ', defaultsTo: _token);
  }

  String questionTextMessage() {
    return prompts.get('Messsage: ');
  }

  void clear() {
    if (Platform.isWindows) {
      // We need to test it on Windows
      print(Process.runSync('cls', [], runInShell: true).stdout);
    } else {
      print(Process.runSync('clear', [], runInShell: true).stdout);
    }
  }
}
