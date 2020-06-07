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
import 'package:http/http.dart';
import 'package:orion_users_client/web_service.dart';
import 'package:orion_users_client/web_socket.dart';

/// methos main
void main() {
  WebClientExample();
}

/// Examples of how to use UsersWebService and UsersWebSocket clients in
/// simple Web page
class WebClientExample {
  /// Users Web Service client
  UsersWebService _usersWS;

  /// Users Web Socket client
  UsersWebSocket _usersSocket;


  WebClientExample() {
    // instantiating the users web service client
    _usersWS = UsersWebService(getSecureValue(), getDevelopmentValue());
    _usersSocket = UsersWebSocket(getSecureValue(), getDevelopmentValue());

    // adding buttons listeners
    // Web Service
    querySelector('#btnCreateUser').onClick.listen(createUserHandler);
    querySelector('#btnUpdateUser').onClick.listen(updateUserHandler);
    querySelector('#btnDeleteUser').onClick.listen(deleteUserHandler);
    querySelector('#btnListUser').onClick.listen(listUserHandler);

   

    // adding checkboxes listeners to change service URL to run with secure
    // connection and dev mode
    querySelector('#secure').onClick.listen(urlHandler);
    querySelector('#development').onClick.listen(urlHandler);
    querySelector('#btnChangeHost').onClick.listen(urlHandler);
  }

  /// Handles the [MouseEvent event] of the button create user
  void createUserHandler(MouseEvent event) async {
    // geting the user data
    var name = (querySelector('#nameCreate') as InputElement).value;
    var email = (querySelector('#emailCreate') as InputElement).value;
    var password = (querySelector('#passwordCreate') as InputElement).value;
    
      String data;
        try {
          // create a user in users service
          var response = await _usersWS.createUser(name, email, password);
          data = json.decode(response.body)['name'+'email'+'password'];

        } on Exception {
          data = 'connection refused';
        } finally {
          // setting the return data to HTML screen
          appendNode(data);
        }
  }

  void updateUserHandler(MouseEvent event) async {
    // geting the user data
    var id = (querySelector('#idUpdate') as InputElement).value;
    var name = (querySelector('#nameUpdate') as InputElement).value;
    var email = (querySelector('#emailUpdate') as InputElement).value;
    var password = (querySelector('#passwordUpdate') as InputElement).value;
    
      String data;
        try {
          // create a user in users service
          var response = await _usersWS.updateUser(id, name, email, password);
          data = json.decode(response.body)['id'+'name'+'email'+'password'];

        } on Exception {
          data = 'connection refused';
        } finally {
          // setting the return data to HTML screen
          appendNode(data);
        }
  }

    void deleteUserHandler(MouseEvent event) async {
    // geting the user data
    var id = (querySelector('#idDelete') as InputElement).value;
    
      String data;
        try {
          // create a user in users service
          var response = await _usersWS.deleteUser(id);
          data = json.decode(response.body)['id'];

        } on Exception {
          data = 'connection refused';
        } finally {
          // setting the return data to HTML screen
          appendNode(data);
        }
  }

    void listUserHandler(MouseEvent event) async {
    // geting the user data
    var id = (querySelector('#idList') as InputElement).value;
    
      String data;
        try {
          // create a user in users service
          var response = await _usersWS.listUser(id);
          data = json.decode(response.body)['id'];

        } on Exception {
          data = 'connection refused';
        } finally {
          // setting the return data to HTML screen
          appendNode(data);
        }
  }

  //  String getPortValue() {
  //   var port = (querySelector('#port') as InputElement).value;
  //   return (port == '') ? '9081' : port;
  // }


  /// Handles the [MouseEvent] of the checkboxes
  void urlHandler(MouseEvent event) {
    // change the url of the service
    _usersWS.changeServiceURL(getSecureValue(), getDevelopmentValue(),
        getHostValue(), getPortValue());
    _usersSocket.changeServiceURL(getSecureValue(), getDevelopmentValue(),
        getHostValue(), getPortValue());

    appendNode(_usersWS.wsURL);
    appendNode(_usersSocket.socketURL);
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
