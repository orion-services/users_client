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
import 'package:orion_talk_client/web_service.dart';
import 'package:orion_talk_client/web_socket.dart';

/// methos main
void main() {
  WebClientExample();
}

/// Examples of how to use TalkWebService and TalkWebSocket clients in
/// simple Web page
class WebClientExample {
  /// Talk Web Service client
  TalkWebService _talkWS;

  /// Talk Web Socket client
  TalkWebSocket _talkSocket;

  WebClientExample() {
    // instantiating the talk web service client
    _talkWS = TalkWebService(getSecureValue(), getDevelopmentValue());
    _talkSocket = TalkWebSocket(getSecureValue(), getDevelopmentValue());

    // adding buttons listeners
    // Web Service
    querySelector('#btnCreateChannel').onClick.listen(createChannelHandler);
    querySelector('#btnSend').onClick.listen(sendMessageHandler);

    // Web socket
    querySelector('#btnSocketConnect').onClick.listen(socketConnectHandler);
    querySelector('#btnSocketSend').onClick.listen(socketSendMessageHandler);
    querySelector('#btnSocketClose').onClick.listen(socketCloseHandler);

    // adding checkboxes listeners to change service URL to run with secure
    // connection and dev mode
    querySelector('#secure').onClick.listen(urlHandler);
    querySelector('#development').onClick.listen(urlHandler);
    querySelector('#btnChangeHost').onClick.listen(urlHandler);
  }

  /// Handles the [MouseEvent event] of the button create channel
  void createChannelHandler(MouseEvent event) async {
    String data;
    try {
      // creates a channel in talk service
      var response = await _talkWS.createChannel();
      data = json.decode(response.body)['token'];
    } on Exception {
      data = 'connection refused';
    } finally {
      // setting the return message to HTML screen
      appendNode(data);
      (querySelector('#channel') as InputElement).value = data;
    }
  }

  /// Handles the [MouseEvent event] of the button send message
  void sendMessageHandler(MouseEvent event) async {
    // Geting the token of a channel from input text and
    // setting the token to Talk Web Service client
    _talkWS.token = (querySelector('#channel') as InputElement).value;

    // geting the message from input text
    var message = (querySelector('#sendMessage') as InputElement).value;

    String data;
    try {
      // sending the message to a channel in talk Service
      var response = await _talkWS.sendTextMessage(message);
      data = json.decode(response.body)['message'];
    } on Exception {
      data = 'connection refused';
    } finally {
      // setting the return message to HTML screen
      appendNode(data);
    }
  }

  /// Handles the [MouseEvent event] of the button to connect with a
  /// Web Socket channel
  void socketConnectHandler(MouseEvent event) {
    // Geting the token of a channel from input text and
    // setting the token to Talk Web Socket client
    _talkSocket.token = (querySelector('#channel') as InputElement).value;
    _talkSocket.connect(_talkSocket.token);
    _talkSocket.registerListener(socketListener);
  }

  /// Handles the [MouseEvent event] of the button to send a message to a
  /// Web Socket channel
  void socketSendMessageHandler(MouseEvent event) {
    var message = (querySelector('#sendMessage') as InputElement).value;
    _talkSocket.send(message);
  }

  /// Handles the [MouseEvent event] of the button to close a connect with a channel
  /// through a web socket
  void socketCloseHandler(MouseEvent event) {
    _talkSocket.close();
  }

  /// listens the [MessageEvent event] through Web Socket channel
  void socketListener(MessageEvent event) {
    appendNode(event.data);
  }

  /// Handles the [MouseEvent] of the checkboxes
  void urlHandler(MouseEvent event) {
    // change the url of the service
    _talkWS.changeServiceURL(getSecureValue(), getDevelopmentValue(),
        getHostValue(), getPortValue());
    _talkSocket.changeServiceURL(getSecureValue(), getDevelopmentValue(),
        getHostValue(), getPortValue());

    appendNode(_talkWS.wsURL);
    appendNode(_talkSocket.socketURL);
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

  /// [return] a string with the port
  String getPortValue() {
    var port = (querySelector('#port') as InputElement).value;
    return (port == '') ? '9081' : port;
  }

  /// append a [String information] in output area in the page
  void appendNode(String information) {
    var node = document.createElement('span');
    var br = document.createElement('br');
    node.innerHtml = information;
    querySelector('#output').append(node);
    querySelector('#output').append(br);
  }
}
