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
import 'package:http/http.dart';

abstract class UserUCInterface {
  /// Creates a user in the service with the arguments [name], [email] and
  /// [password]
  Future<Response> createUser(String name, String email, String password);

  /// Creates and authenticates a user in the service with the arguments [name], [email] and
  /// [password]
  Future<Response> createAuthenticate(
      String name, String email, String password);

  /// Authenticates an user in the service using [email] and [password]
  Future<Response> authenticate(String email, String password);

  void changeServiceConnection(bool https, String host, String port);

  /// Change an user password in the service using [email], [password] and
  /// [newPassword]
  Future<Response> updatePassword(
      String email, String password, String newPassword);

  /// Send a new password to the [email]
  Future<Response> recoverPassword(String email);

  /// Deletes the user that uses the [email]
  Future<Response> deleteUser(String email);

  /// update the user [email] to [newEmail]
  Future<Response> updateEmail(String email, String newEmail, String jwt);
}
