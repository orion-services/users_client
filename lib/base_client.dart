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

  /// the host of the service
  String host;

  /// the port of the service
  String port;

  String wsEndpoint;

  /// the api version
  String api;

  /// the result url for the Web Service
  String wsURL;

  /// the token of the user
  String token;

  /// [bool enableHTTPS] indicates if will be used a secure protocol
  BaseClient(bool enableHTTPS) {
    host = 'localhost';
    port = '8080';
    wsEndpoint = 'user';
    api = 'api';
    changeServiceURL(enableHTTPS, host, port);
  }

  void changeServiceURL(
      bool enableHTTPS, String newHost, String newPort) {
    host = newHost;
    port = newPort;
    _enableSecurityProtocol(enableHTTPS);
    _montURL();
  }

  void _enableSecurityProtocol(bool enableHTTPS) {
    if (enableHTTPS) {
      wsURL = 'https://';
    } else {
      wsURL = 'http://';
    }
  }

  void _montURL() {
    String urlBase = host + ':' + port;
    wsURL = wsURL + urlBase + '/' + api + '/' + wsEndpoint + '/';
  }
}
