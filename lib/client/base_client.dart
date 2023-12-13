/// Copyright 2022 Orion Services @ https://github.com/orion-services
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

import 'package:dio/dio.dart';

class BaseClient {
  // use https to make a request
  late bool https;

  /// the host of the service
  late String host;

  /// the port of the service
  late String port;

  late String wsEndpoint;

  /// the api version
  late String api;

  /// the result url
  late String wsURL;

  late Dio dio;

  /// [bool https] indicates if the client will make requests over http or https
  /// [String host] the host of the service
  /// [String port] the port used by the service
  BaseClient(
      [this.https = false, this.host = 'localhost', this.port = '8080']) {
    wsEndpoint = 'users';
    api = 'api';
    changeServiceConnection(https, host, port);
    dio = Dio(BaseOptions(
      connectTimeout: Duration(seconds: 5),
      sendTimeout: Duration(seconds: 5),
    ));
  }

  /// Method used to change parameters to connect in users service
  /// [bool https] indicates if the client will use http or https
  /// [String host] the host of the service
  /// [String port] the port used by the service
  void changeServiceConnection(bool https, String host, String port) {
    this.host = host;
    this.port = port;
    _handleHTTP(https);
    _createURL();
  }

  /// [bool https] indicates if the client will use http or https
  void _handleHTTP(bool https) {
    if (https) {
      wsURL = 'https://';
    } else {
      wsURL = 'http://';
    }
  }

  /// Creates the final URL to connect make requests in the user services
  void _createURL() {
    var urlBase = host + ':' + port;
    wsURL = wsURL + urlBase + '/' + api + '/' + wsEndpoint + '/';
  }

  Future<Response> get(
    String path, {
    Map<String, Object?>? headers,
  }) {
    return dio.get(path,
        options: Options(
          headers: headers,
          responseType: ResponseType.plain,
        ));
  }

  Future<Response> put(String path,
      {Map<String, Object?>? headers, Object? body}) {
    return dio.put(path,
        data: body,
        options: Options(
          headers: headers,
          contentType: Headers.formUrlEncodedContentType,
          responseType: ResponseType.plain,
        ));
  }

  Future<Response> post(String path,
      {Map<String, Object?>? headers, Object? body}) {
    return dio.post(path,
        data: body,
        options: Options(
          headers: headers,
          contentType: Headers.formUrlEncodedContentType,
          responseType: ResponseType.plain,
        ));
  }

  Future<Response> delete(String path,
      {Map<String, Object?>? headers, Object? body}) {
    return dio.delete(path,
        data: body,
        options: Options(
          headers: headers,
          contentType: Headers.formUrlEncodedContentType,
          responseType: ResponseType.plain,
        ));
  }
}
