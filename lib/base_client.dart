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
class BaseClient {
  /// the host of the service
  String host;

  /// the port of the service
  String port;

  /// the name of the app
  String app;

  /// the service endpoint name
  String wsEndpoint;

  /// the socket endpoint name
  String socketEndpoint;

  /// the api version
  String api;

  /// the result url for the Web Service
  String wsURL;

  /// the result url for the Web Socket
  String socketURL;

  /// the token of a channel
  String token;


  /// [bool enableSecurity] indicates if will be used a secure protocol
  /// and [bool devMode] changes the URL of remove for development mode
  BaseClient(bool enableSecurity, bool devMode) {
    app = 'orion-users-service';
    host = 'localhost';
    port = '9080';
    wsEndpoint = 'users';
    socketEndpoint = 'usersws';
    api = 'api/v1';

    changeServiceURL(enableSecurity, devMode, host, port);
  }

  void changeServiceURL(
      bool enableSecurity, bool devMode, String newHost, String newPort) {
    host = newHost;
    port = newPort;
    _enableSecurityProtocol(enableSecurity);
    _enableDevMode(devMode);
  }

  void _enableSecurityProtocol(bool enableSecurity) {
    if (enableSecurity) {
      wsURL = 'https://';
      socketURL = 'wss://';
    } else {
      wsURL = 'http://';
      socketURL = 'ws://';
    }
  }

  /// cuts the app name from the url to enable developer mode
  void _enableDevMode(bool devMode) {
    String urlBase;
    if (devMode) {
      urlBase = host + ':' + port;
      wsURL = wsURL + urlBase + '/' + wsEndpoint + '/' + api + '/';
      socketURL = socketURL + urlBase + '/' + socketEndpoint + '/';
    } else {
      urlBase = host + ':' + port;
      wsURL = wsURL + urlBase + '/' + app + '/' + wsEndpoint + '/' + api + '/';
      socketURL = socketURL + urlBase + '/' + app + '/' + socketEndpoint + '/';
    }
  }
}
