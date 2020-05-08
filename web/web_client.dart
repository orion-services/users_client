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

void main() {
  WebClientExample();
}

///
class WebClientExample {
  TalkWebServiceClient _talk;

  WebClientExample() {
    // Instantiatinc the Talk Web Service Client
    _talk = TalkWebServiceClient();

    // adding the listeners to button 'create channel' and 'send message'
    querySelector('#btnChannel').onClick.listen(btnChannelHandler);
    querySelector('#btnSend').onClick.listen(btnSendHandler);
  }

  void btnSendHandler(MouseEvent event) {
    // Geting the token of a channel from input text and
    // setting the token to Talk Web Service client
    _talk.token = (querySelector('#channel') as InputElement).value;
    // geting the message from input text
    var message = (querySelector('#textField') as InputElement).value;
    // sending the message to Talk Service
    _talk.sendTextMessage(message).then((response) =>
        // setting the return message to HTML screen
        querySelector('#output')
            .appendText(json.decode(response.body)['message']));
  }

  void btnChannelHandler(MouseEvent event) {
    _talk.createChannel().then((response) =>
        (querySelector('#channel') as InputElement).value =
            json.decode(response.body)['token']);
  }
}
