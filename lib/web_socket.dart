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
//import 'dart:html';
import 'dart:html';
import 'package:orion_talk_client/base_client.dart';

/// Web Socket client for Talk microservice
class TalkWebSocket extends BaseClient {
  // the Web Socket Object from dart:html package
  WebSocket _websocket;

  /// instatiate a TalkWebService object.
  /// [bool enableSecurity] indicates is the client will work with http or https
  ///
  /// [bool devMode] modify the service URL to operates in dev mode. In development
  /// mode, Open liberty modifies the service URL eliminating When we are the application
  /// name orion-talk-service
  ///
  /// [String tockenChannel] indicates the token a channel (optional)
  TalkWebSocket(bool enableSecurity, bool devMode, [String tokenChannel])
      : super(enableSecurity, devMode) {
    token = tokenChannel;
  }

  /// connects to channel using a [String token]
  void connect(String token) {
    _websocket = WebSocket(socketURL + token);
  }

  /// registers a [Function listener] of the connected channel
  void registerListener(Function listener) {
    _websocket.onMessage.listen(listener);
  }

  /// sends a [String message] to a channel
  void send(String message) {
    _websocket.send(message);
  }

  /// closes the connection with a channel
  void close() {
    _websocket.close();
  }
}
