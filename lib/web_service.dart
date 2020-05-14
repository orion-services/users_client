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
import 'package:http/http.dart' as http;
import 'package:orion_talk_client/base_client.dart';

/// Web Service for Talk microservice
class TalkWebService extends BaseClient {
  /// instatiate a TalkWebService object.
  /// [bool enableSecurity] indicates is the client will work with http or https
  ///
  /// [bool devMode] modify the service URL to operates in dev mode. In development
  /// mode, Open liberty modifies the service URL eliminating When we are the application
  /// name orion-talk-service
  ///
  /// [String tockenChannel] indicates the token a channel (optional)
  TalkWebService(bool enableSecurity, bool devMode, [String tokenChannel])
      : super(enableSecurity, devMode) {
    // sets the tocken of a channel
    token = tokenChannel;
  }

  /// Web Serive: creates a Channel in the Oriton Talk microservices
  /// and returns [Future<http.Response>]
  Future<http.Response> createChannel() {
    var url = wsURL + 'create';
    return http.get(url);
  }

  /// Web Serive: sends a [message] to a channel through a [token] and
  /// returns [Future<http.Response>]
  Future<http.Response> sendTextMessage(String message) {
    var url = wsURL + 'send';
    return http.post(url, body: {'token': token, 'message': message});
  }

  /// Web Serive: loads a channel through a [token] to retrieve all messages
  /// and returns [Future<http.Response>]
  Future<http.Response> loadMessages(String token) {
    var url = wsURL + 'load' + '/' + token;
    print(url);
    return http.get(url);
  }
}
