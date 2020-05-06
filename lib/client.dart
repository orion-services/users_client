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
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class TalkClient {
  String _host;
  String _port;
  String _serviceEndpoint;
  String _socketEndpoint;
  String _api;
  String _serviceURL;
  String _socketURL;

  IOWebSocketChannel _channel;

  TalkClient() {
    _host = 'localhost';
    _port = '9081';
    _serviceEndpoint = 'talk';
    _socketEndpoint = 'talkws';
    _api = 'api/v1.0';

    _serviceURL = 'http://' +
        _host +
        ':' +
        _port +
        '/' +
        _serviceEndpoint +
        '/' +
        _api +
        '/';

    _socketURL = 'ws://' + _host + ':' + _port + '/' + _socketEndpoint + '/';

    _channel = null;
  }

  /// Web Socket: connects in a channel using a [token]
  Future<void> connect(String token, Function callback) async {
    if (_channel == null) {
      _channel = await IOWebSocketChannel.connect(_socketURL + token);
      _channel.stream.listen(callback);
    }
  }

  /// Web Socket: sends a message to a channel through a [token]
  Future<void> send(String message) async {
    await _channel.sink.add(message);
  }

  Future<void> close() async {
    await _channel.sink.close(status.goingAway);
  }

  /// Web Serive: creates a Channel in the Oriton Talk microservices
  /// and returns [Future<http.Response>]
  Future<http.Response> createChannel() async {
    var url = _serviceURL + 'create';
    return await http.get(url);
  }

  /// Web Serive: sends a [message] to a channel through a [token] and
  /// returns [Future<http.Response>]
  Future<http.Response> sendTextMessage(String token, String message) async {
    var url = _serviceURL + 'send';
    print(url);
    return await http.post(url, body: {'token': token, 'message': message});
  }

  /// Web Serive: loads a channel through a [token] to retrieve all messages
  /// and returns [Future<http.Response>]
  Future<http.Response> loadMessages(String token) async {
    var url = _serviceURL + 'load' + '/' + token;
    return await http.get(url);
  }

  String getHost() {
    return _host;
  }

  void setHost(String host) {
    _host = host;
  }

  String getPort() {
    return _port;
  }

  void setPort(String port) {
    _port = port;
  }
}
