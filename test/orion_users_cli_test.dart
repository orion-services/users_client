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
import 'dart:async';

import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:users_client/client/user_ws.dart';
import 'package:users_client/uc/user_uc_interface.dart';
import 'package:users_client/uc/user_uc.dart';

import 'orion_users_cli_test.mocks.dart';

@GenerateMocks([UsersWebService])
void main() {
  test('Create an user with small password', () {
    UserUCInterface uc = UserUC();
    expect(() => uc.createUser('Orion', 'orion@test.com', '12345678'),
        throwsException);
  });

  test('Create user with a blank name', () {
    UserUCInterface uc = UserUC();
    expect(
        () => uc.createUser('', 'orion@test.com', '12345678'), throwsException);
  });

  test('Create user with a blank e-mail', () {
    UserUCInterface uc = UserUC();
    expect(() => uc.createUser('Orion', '', '12345678'), throwsException);
  });

  test('Create user with a blank password', () {
    UserUCInterface uc = UserUC();
    expect(() => uc.createUser('Orion', 'orion@test.com', ''), throwsException);
  });

  test('Create user with an e-mail invalid', () {
    UserUCInterface uc = UserUC();
    expect(() => uc.createUser('Orion', 'orion#test.com', '12345678'),
        throwsException);
  });

  test('Create an user', () {
    var ws = MockUsersWebService();
    when(ws.createUser('Orion', 'orion@test.com', '12345678'))
        .thenAnswer((_) => Future<Response>.value(Response('body', 200)));

    UserUCInterface uc = UserUC();
    var response = uc.createUser('Orion', 'orion@test.com', '12345678');
    response.then((value) => {expect(200, value.statusCode)});
  });

  test('Create and authenticates a user', () {
    var ws = MockUsersWebService();
    when(ws.createUser('Orion', 'orion@test.com', '12345678'))
        .thenAnswer((_) => Future<Response>.value(Response('body', 200)));

    UserUCInterface uc = UserUC();
    var response = uc.createAuthenticate('Orion', 'orion@test.com', '12345678');
    response.then((value) => {expect(200, value.statusCode)});
  });
}
