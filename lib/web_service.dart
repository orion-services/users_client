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
import 'package:http/http.dart' as http;
import 'package:orion_users_client/base_client.dart';

/// Web Service for User microservice
class UserWebService extends BaseClient {
  /// instatiate a UserWebService object.
  /// [bool enableSecurity] indicates is the client will work with http or https
  ///
  /// [bool devMode] modify the service URL to operates in dev mode. In development
  /// mode, Open liberty modifies the service URL eliminating When we are the application
  /// name orion-user-service
  ///
  /// [String tockenChannel] indicates the token a channel (optional)
  UserWebService(bool enableSecurity, bool devMode, [String tokenChannel])
      : super(enableSecurity, devMode) {
    // sets the tocken of a channel
    token = tokenChannel;
  }


    /// Web Serive: creates a user in the Oriton User microservices
  /// and returns [Future<http.Response>]
  Future<http.Response> createUser(String name, String email) {
    var url = wsURL + 'createusers';
    return http.post(url, body: {'name': name, 'email': email});
  }

   /// Web Serive: uodate a user in the Oriton User microservices
  /// and returns [Future<http.Response>]
    Future<http.Response> updateUser(String id, String name, String email) {
    var url = wsURL + 'updateusers';
    return http.post(url, body: {'id': id, 'name': name, 'email': email});
  }

     /// Web Serive: uodate a user in the Oriton User microservices
  /// and returns [Future<http.Response>]
    Future<http.Response> deleteUser(String id) {
    var url = wsURL + 'updateusers';
    return http.post(url, body: {'id': id});
  }

       /// Web Serive: uodate a user in the Oriton User microservices
  /// and returns [Future<http.Response>]
    Future<http.Response> listUser(String id) {
    var url = wsURL + 'listusers' + '/' + id;
    print(url);
    return http.get(url);
  }


}
