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
import 'dart:html';
import 'dart:convert';
import 'package:orion_talk_client/service_client.dart';

/// methos main
void main() {
  WebClientExample();
}

/// Examples of how to use TalkWebServiceClient and TalkWebSocket clients in
/// simple Web page
class WebClientExample {
  TalkWebServiceClient _talk;

  WebClientExample() {
    // instantiating the talk web service client
    _talk = TalkWebServiceClient(getSecureValue(), getDevelopmentValue());

    // adding buttons listeners
    querySelector('#btnChannel').onClick.listen(createChannelHandler);
    querySelector('#btnSend').onClick.listen(sendMessageHandler);

    // adding checkboxes listeners to change service URL to run with secure
    // connection and dev mode
    querySelector('#secure').onClick.listen(urlHandler);
    querySelector('#development').onClick.listen(urlHandler);
    querySelector('#btnChangeHost').onClick.listen(urlHandler);
  }

  /// Handles the [MouseEvent] of the button create channel
  void createChannelHandler(MouseEvent event) async {
    String data;
    try {
      // creates a channel in talk service
      var response = await _talk.createChannel();
      data = json.decode(response.body)['token'];
    } on Exception {
      data = 'talk service connection problem';
    } finally {
      // setting the return message to HTML screen
      (querySelector('#channel') as InputElement).value = data;
    }
  }

  /// Handles the [MouseEvent] of the button send message
  void sendMessageHandler(MouseEvent event) async {
    // Geting the token of a channel from input text and
    // setting the token to Talk Web Service client
    _talk.token = (querySelector('#channel') as InputElement).value;

    // geting the message from input text
    var message = (querySelector('#sendMessage') as InputElement).value;

    String data;
    try {
      // sending the message to a channel in talk Service
      var response = await _talk.sendTextMessage(message);
      data = json.decode(response.body)['message'];
    } on Exception {
      data = 'talk service connection problem';
    } finally {
      // setting the return message to HTML screen
      querySelector('#output').appendText(data);
    }
  }

  /// Handles the [MouseEvent] of the checkboxes
  void urlHandler(MouseEvent event) {
    // change the url of the service
    _talk.changeServiceURL(
        getSecureValue(), getDevelopmentValue(), getHostValue());
  }

  /// [return] a boolean indicating a secure conection or not
  bool getSecureValue() {
    return (querySelector('#secure') as InputElement).checked;
  }

  /// [return] a boolean indicating if the service will run in dev mode
  bool getDevelopmentValue() {
    return (querySelector('#development') as InputElement).checked;
  }

  /// [return] a string with the host
  String getHostValue() {
    var host = (querySelector('#host') as InputElement).value;
    return (host == '') ? 'localhost' : host;
  }
}
