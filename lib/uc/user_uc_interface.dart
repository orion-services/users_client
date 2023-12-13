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

abstract class UserUCInterface {
  /// Creates a user in the service with the arguments [name], [email] and
  /// [password]
  Future<Response> createUser(String name, String email, String password);

  /// Authenticates an user in the service using [email] and [password]
  Future<Response> authenticate(String email, String password);

  /// Creates and authenticates a user in the service with the arguments
  /// [name], [email] and [password]
  Future<Response> createAuthenticate(
      String name, String email, String password);

  /// Sends a new password to the [email]
  Future<Response> recoverPassword(String email);

  /// Updates the user [email] to [newEmail]
  Future<Response> updateEmail(String email, String newEmail, String jwt);

  /// Changes the user's password in the service using [email], [password],
  /// [newPassword] and [jwt]
  Future<Response> updatePassword(
      String email, String password, String newPassword, String jwt);

  /// Deletes the user according the [email] and [jwt]
  Future<Response> deleteUser(String email, String jwt);

  /// [bool https] indicates if the client will use http or https
  /// [String host] the host of the service
  /// [String port] the port used by the service
  void changeServiceConnection(bool https, String host, String port);
}
