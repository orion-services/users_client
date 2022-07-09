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

  /// Authenticates an user in the service using [email] and [password]
  Future<Response> login(String email, String password);
}
