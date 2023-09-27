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
import 'package:dio/dio.dart';
import 'package:users_client/client/base_client.dart';

/// Abstracts the endpoints of the users service
class OrionUsers extends BaseClient {
  /// Creates a user in the users services and returns [Future<http.Response>]
  Future<Response> createUser(String name, String email, String password) {
    var url = wsURL + 'create';
    return post(url,
        body: {'name': name, 'email': email, 'password': password});
  }

  /// Creates and authenticates a user in the users services and returns
  /// [Future<Response>]
  Future<Response> createAuthenticate(
      String name, String email, String password) {
    var url = wsURL + 'createAuthenticate';
    return post(url,
        body: {'name': name, 'email': email, 'password': password});
  }

  /// Authenticates the users services and returns [Future<Response>]
  Future<Response> authenticate(String email, String password) {
    var url = wsURL + 'authenticate';
    return post(url, body: {'email': email, 'password': password});
  }

  /// Send a hash by email in the users services and returns
  /// [Future<Response>]
  Future<Response> forgotUser(String email) {
    var url = wsURL + 'forgot';
    return post(url, body: {'email': email});
  }

  /// Retrieve a password in the users services and returns
  /// [Future<Response>]
  Future<Response> retrieveUser(String hash, String password) {
    var url = wsURL + 'retrieve';
    return post(url, body: {'hash': hash, 'password': password});
  }

  /// updates a user in the users services and returns [Future<Response>]
  Future<Response> updateUser(
      String id, String name, String email, String password, String jwt) {
    var url = wsURL + 'update';
    return post(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + jwt},
        body: {'id': id, 'name': name, 'email': email, 'password': password});
  }

  /// updates the email from a user in the users services and returns [Future<Response>]
  Future<Response> updateEmail(String email, String newEmail, jwt) {
    var url = wsURL + 'update/email';
    return put(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + jwt},
        body: {'email': email, 'newEmail': newEmail});
  }

  /// Deletes a user in the users services and returns [Future<Response>]
  Future<Response> deleteUser(String email, String jwt) {
    var url = wsURL + 'delete';
    return delete(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + jwt},
        body: {'email': email});
  }

  /// Lists a user in the users services and returns [Future<Response>]
  Future<Response> listUser(String id, String jwt) {
    var url = wsURL + 'list' + '/' + id;
    print(url);
    return get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + jwt});
  }

  /// Lists a user in the users services and returns [Future<Response>]
  Future<Response> updatePassword(
      String email, String password, String newPassword, String jwt) {
    var url = wsURL + 'update' + '/' + 'password';

    return put(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + jwt
    }, body: {
      'email': email,
      'password': password,
      'newPassword': newPassword
    });
  }

  /// Recoveries the password of the user sending an [e-mail]
  Future<Response> recoverPassword(String email) {
    var url = wsURL + 'recoverPassword';
    return post(url, body: {
      'email': email,
    });
  }
}
