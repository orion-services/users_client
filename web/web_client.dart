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
    _talk = TalkWebServiceClient();

    // adding the listeners to button 'create channel' and 'send message'
    querySelector('#btnChannel').onClick.listen(btnCreateChannelHandler);
    querySelector('#btnSend').onClick.listen(btnSendMessageHandler);
  }

  /// Handle the [MouseEvent] of the button send message
  void btnSendMessageHandler(MouseEvent event) async {
    // Geting the token of a channel from input text and
    // setting the token to Talk Web Service client
    _talk.token = (querySelector('#channel') as InputElement).value;
    // geting the message from input text
    var message = (querySelector('#textField') as InputElement).value;

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

  /// Handle the [MouseEvent] of the button create channel
  void btnCreateChannelHandler(MouseEvent event) async {
    String data;
    try {
      // creates a channel in talk service
      var response = await _talk.createChannel();
      data = json.decode(response.body)['token'];
    } on Exception {
      data = 'talk service connection problem';
    } finally {
      // setting the return message to HTML screen
      querySelector('#output').appendText(data);
    }
  }
}
