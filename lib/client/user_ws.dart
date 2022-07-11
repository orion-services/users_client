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
import 'dart:io';
import 'package:users_client/client/base_client.dart';
import 'package:http/http.dart' as http;

String teste = 'teste';

/// Web Service for User microservice
class UsersWebService extends BaseClient {
  /// instantiate a UserWebService object.
  /// [bool enableSecurity] indicates is the client will work with http or https
  /// [String userToken] indicates the token (optional)
  UsersWebService(bool enableSecurity, [String userToken])
      : super(enableSecurity) {
    // sets the token of a channel
    token = userToken;
  }

  /// Web Service: Login the Orion Users
  /// and returns [Future<http.Response>]
  Future<http.Response> login(String email, String password) {
    var url = wsURL + 'login';
    return http.post(Uri.parse(url), body: {'email': email, 'password': password});
  }

  /// Web Service: Creates a user in the Orion Users
  /// and returns [Future<http.Response>]
  Future<http.Response> createUser(String name, String email, String password) {
    String url = wsURL + 'create';
    return http
        .post(Uri.parse(url), body: {'name': name, 'email': email, 'password': password});
  }

  /// Web Service: Send a hash by email in the Orion Users
  /// and returns [Future<http.Response>]
  Future<http.Response> forgotUser(String email) {
    var url = wsURL + 'forgot';
    return http.post(Uri.parse(url), body: {'email': email});
  }

  /// Web Service: Retrieve a password in the Orion Users
  /// and returns [Future<http.Response>]
  Future<http.Response> retrieveUser(String hash, String password) {
    var url = wsURL + 'retrieve';
    return http.post(Uri.parse(url), body: {'hash': hash, 'password': password});
  }

  /// Web Service: update a user in the Orion Users
  /// and returns [Future<http.Response>]
  Future<http.Response> updateUser(
      String id, String name, String email, String password, String jwt) {
    var url = wsURL + 'update';
    return http.post(Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + jwt},
        body: {'id': id, 'name': name, 'email': email, 'password': password});
  }

  /// Web Service: Delete a user in the Orion Users
  /// and returns [Future<http.Response>]
  Future<http.Response> deleteUser(String id, String jwt) {
    var url = wsURL + 'delete';
    return http.post(Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + jwt},
        body: {'id': id});
  }

  /// Web Service: List a user in the Orion Users
  /// and returns [Future<http.Response>]
  Future<http.Response> listUser(String id, String jwt) {
    var url = wsURL + 'list' + '/' + id;
    print(url);
    return http
        .get(Uri.parse(url), headers: {HttpHeaders.authorizationHeader: 'Bearer ' + jwt});
  }
}
