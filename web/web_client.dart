// /// Copyright 2022 Orion Services @ https://github.com/orion-services
// /// Licensed under the Apache License, Version 2.0 (the "License");
// /// you may not use this file except in compliance with the License.
// /// You may obtain a copy of the License at
// ///
// /// http://www.apache.org/licenses/LICENSE-2.0
// ///
// /// Unless required by applicable law or agreed to in writing, software
// /// distributed under the License is distributed on an "AS IS" BASIS,
// /// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// /// See the License for the specific language governing permissions and
// ///  limitations under the License.
// import 'dart:html';
// import 'dart:convert';
// import 'package:http/http.dart';
// import 'package:users_client/client/user_ws.dart';

// /// main
// void main() {
//   WebClientExample();
// }

// /// Examples of how to use UsersWebService and UsersWebSocket clients in
// /// simple Web page
// class WebClientExample {
//   /// Users Web Service client
//   UsersWebService _ws;

//   /// JSON Web Token;
//   String _jwt;

//   WebClientExample() {
//     // instantiating the users web service client
//     _ws = UsersWebService(getSecureValue(), getDevelopmentValue());

//     // adding buttons listeners
//     // Web Service
//     querySelector('#btnCreateUser').onClick.listen(createUserHandler);
//     querySelector('#btnUpdateUser').onClick.listen(updateUserHandler);
//     querySelector('#btnDeleteUser').onClick.listen(deleteUserHandler);
//     querySelector('#btnListUser').onClick.listen(listUserHandler);

//     // adding checkboxes listeners to change service URL to run with secure
//     // connection and dev mode
//     querySelector('#secure').onClick.listen(urlHandler);
//     querySelector('#development').onClick.listen(urlHandler);
//     querySelector('#btnChangeHost').onClick.listen(urlHandler);
//   }

//   /// Handles the [MouseEvent event] of the authenticate button
//   void authenticateHandler(MouseEvent event) async {
//     try {
//       var user = (querySelector('#user') as InputElement).value;
//       var password = (querySelector('#password') as InputElement).value;
//       var response = await _ws.authenticate(user, password);
//       _jwt = response.body;
//     } on Exception catch (e, stacktrace) {
//       _jwt = stacktrace.toString();
//     } finally {
//       appendNode(_jwt);
//     }
//   }

//   /// Handles the [MouseEvent event] of the button create user
//   void createUserHandler(MouseEvent event) async {
//     // getting the user data
//     var name = (querySelector('#nameCreate') as InputElement).value;
//     var email = (querySelector('#emailCreate') as InputElement).value;
//     var password = (querySelector('#passwordCreate') as InputElement).value;

//     String data;
//     try {
//       // create a user in users service
//       var response = await _ws.createUser(name, email, password);
//       data = json.decode(response.body)['name' + 'email' + 'password'];
//     } on Exception {
//       data = 'connection refused';
//     } finally {
//       // setting the return data to HTML screen
//       appendNode(data);
//     }
//   }

//   void updateUserHandler(MouseEvent event) async {
//     // getting the user data
//     var id = (querySelector('#idUpdate') as InputElement).value;
//     var name = (querySelector('#nameUpdate') as InputElement).value;
//     var email = (querySelector('#emailUpdate') as InputElement).value;
//     var password = (querySelector('#passwordUpdate') as InputElement).value;

//     String data;
//     try {
//       // create a user in users service
//       var response = await _ws.updateUser(id, name, email, password, _jwt);
//       data = json.decode(response.body)['id' + 'name' + 'email' + 'password'];
//     } on Exception {
//       data = 'connection refused';
//     } finally {
//       // setting the return data to HTML screen
//       appendNode(data);
//     }
//   }

//   void deleteUserHandler(MouseEvent event) async {
//     // getting the user data
//     var id = (querySelector('#idDelete') as InputElement).value;

//     String data;
//     try {
//       // create a user in users service
//       var response = await _ws.deleteUser(id, _jwt);
//       data = json.decode(response.body)['id'];
//     } on Exception {
//       data = 'connection refused';
//     } finally {
//       // setting the return data to HTML screen
//       appendNode(data);
//     }
//   }

//   void listUserHandler(MouseEvent event) async {
//     // getting the user data
//     var id = (querySelector('#idList') as InputElement).value;

//     String data;
//     try {
//       // create a user in users service
//       var response = await _ws.listUser(id, _jwt);
//       data = json.decode(response.body)['id'];
//     } on Exception {
//       data = 'connection refused';
//     } finally {
//       // setting the return data to HTML screen
//       appendNode(data);
//     }
//   }

//   /// Handles the [MouseEvent] of the checkboxes
//   void urlHandler(MouseEvent event) {
//     // change the url of the service
//     _ws.changeServiceURL(getSecureValue(), getDevelopmentValue(),
//         getHostValue(), getPortValue());

//     appendNode(_ws.wsURL);
//   }

//   /// [return] a boolean indicating a secure connection or not
//   bool getSecureValue() {
//     return (querySelector('#secure') as InputElement).checked;
//   }

//   /// [return] a boolean indicating if the service will run in dev mode
//   bool getDevelopmentValue() {
//     return (querySelector('#development') as InputElement).checked;
//   }

//   /// [return] a string with the host
//   String getHostValue() {
//     var host = (querySelector('#host') as InputElement).value;
//     return (host == '') ? 'localhost' : host;
//   }

//   /// [return] a string with the port
//   String getPortValue() {
//     var port = (querySelector('#port') as InputElement).value;
//     return (port == '') ? '9081' : port;
//   }

//   /// append a [String information] in output area in the page
//   void appendNode(String information) {
//     var node = document.createElement('span');
//     var br = document.createElement('br');
//     node.innerHtml = information;
//     querySelector('#output').append(node);
//     querySelector('#output').append(br);
//   }
// }
