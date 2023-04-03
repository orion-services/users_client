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
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart';
import 'package:users_client/client/user_ws.dart';
import 'package:users_client/uc/user_uc_interface.dart';

class UsersClient implements UserUCInterface {
  late OrionUsers _service;

  UsersClient() {
    _service = OrionUsers();
  }

  /// Creates a user in the service with the arguments [name], [email] and
  /// [password]
  @override
  Future<Response> createUser(String name, String email, String password) {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        !EmailValidator.validate(email)) {
      throw Exception(
          'The arguments must be not empty and the e-mail must be valid');
    } else {
      if (password.length < 8) {
        throw Exception('The password must have at least eight characters');
      } else {
        return _service.createUser(name, email, password);
      }
    }
  }

  /// Authenticates an user in the service using [email] and [password]
  @override
  Future<Response> authenticate(String email, String password) {
    if (email.isEmpty || password.isEmpty || !EmailValidator.validate(email)) {
      throw Exception(
          'The arguments must be not empty and the e-mail must be valid');
    } else {
      return _service.authenticate(email, password);
    }
  }

  @override
  Future<Response> createAuthenticate(
      String name, String email, String password) {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        !EmailValidator.validate(email)) {
      throw Exception(
          'The arguments must be not empty and the e-mail must be valid');
    } else {
      if (password.length < 8) {
        throw Exception('The password must have at least eight characters');
      } else {
        return _service.createAuthenticate(name, email, password);
      }
    }
  }

  @override
  Future<Response> recoverPassword(String email) {
    if (email.isEmpty) {
      throw Exception('The E-mail must not be empty');
    }
    if (!EmailValidator.validate(email)) {
      throw Exception('E-mail must be valid');
    }
    return _service.recoverPassword(email);
  }

  @override
  Future<Response> updateEmail(String email, String newEmail, String jwt) {
    if (email.isEmpty || newEmail.isEmpty || jwt.isEmpty) {
      throw Exception('All data must be provided');
    }
    if (!EmailValidator.validate(email) || !EmailValidator.validate(newEmail)) {
      throw Exception('E-mail must be valid');
    }
    return _service.updateEmail(email, newEmail, jwt);
  }

  @override
  Future<Response> updatePassword(
      String email, String password, String newPassword, String jwt) {
    if (email.isEmpty ||
        password.isEmpty ||
        newPassword.isEmpty ||
        jwt.isEmpty) {
      throw Exception('The arguments must be not empty');
    }
    if (!EmailValidator.validate(email)) {
      throw Exception('E-mail must be valid');
    }
    if (password.length < 8) {
      throw Exception('The password must have at least eight characters');
    } else {
      return _service.updatePassword(email, password, newPassword, jwt);
    }
  }

  @override
  Future<Response> deleteUser(String email, String jwt) {
    if (email.isEmpty) {
      throw Exception('The E-mail must not be empty');
    }
    if (!EmailValidator.validate(email)) {
      throw Exception('E-mail must be valid');
    }
    return _service.deleteUser(email, jwt);
  }

  @override
  void changeServiceConnection(bool https, String host, String port) {
    _service.changeServiceConnection(https, host, port);
  }
}
