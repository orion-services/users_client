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

class TalkWebServiceClient extends BaseClient {
  TalkWebServiceClient([String tokenChannel]) {
    token = tokenChannel;
  }

  /// Web Serive: creates a Channel in the Oriton Talk microservices
  /// and returns [Future<http.Response>]
  Future<http.Response> createChannel() async {
    var url = serviceURL + 'create';
    return await http.get(url);
  }

  /// Web Serive: sends a [message] to a channel through a [token] and
  /// returns [Future<http.Response>]
  Future<http.Response> sendTextMessage(String message) async {
    var url = serviceURL + 'send';
    return await http.post(url, body: {'token': token, 'message': message});
  }

  /// Web Serive: loads a channel through a [token] to retrieve all messages
  /// and returns [Future<http.Response>]
  Future<http.Response> loadMessages(String token) async {
    var url = serviceURL + 'load' + '/' + token;
    return await http.get(url);
  }
}