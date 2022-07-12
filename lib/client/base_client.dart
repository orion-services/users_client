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

  /// [bool https] indicates if the client will make requests over http or https
  /// [String host] the host of the service
  /// [String port] the port used by the service
  BaseClient(
      [this.https = false, this.host = 'localhost', this.port = '8080']) {
    wsEndpoint = 'user';
    api = 'api';
    changeServiceConnection(https, host, port);
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
}
