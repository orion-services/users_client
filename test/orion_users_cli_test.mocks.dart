// Mocks generated by Mockito 5.2.0 from annotations
// in users_client/test/orion_users_cli_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:users_client/client/user_ws.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeResponse_0 extends _i1.Fake implements _i2.Response {}

/// A class which mocks [UsersWebService].
///
/// See the documentation for Mockito's code generation for more information.
class MockUsersWebService extends _i1.Mock implements _i3.UsersWebService {
  MockUsersWebService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get https =>
      (super.noSuchMethod(Invocation.getter(#https), returnValue: false)
          as bool);
  @override
  set https(bool? _https) =>
      super.noSuchMethod(Invocation.setter(#https, _https),
          returnValueForMissingStub: null);
  @override
  String get host =>
      (super.noSuchMethod(Invocation.getter(#host), returnValue: '') as String);
  @override
  set host(String? _host) => super.noSuchMethod(Invocation.setter(#host, _host),
      returnValueForMissingStub: null);
  @override
  String get port =>
      (super.noSuchMethod(Invocation.getter(#port), returnValue: '') as String);
  @override
  set port(String? _port) => super.noSuchMethod(Invocation.setter(#port, _port),
      returnValueForMissingStub: null);
  @override
  String get wsEndpoint =>
      (super.noSuchMethod(Invocation.getter(#wsEndpoint), returnValue: '')
          as String);
  @override
  set wsEndpoint(String? _wsEndpoint) =>
      super.noSuchMethod(Invocation.setter(#wsEndpoint, _wsEndpoint),
          returnValueForMissingStub: null);
  @override
  String get api =>
      (super.noSuchMethod(Invocation.getter(#api), returnValue: '') as String);
  @override
  set api(String? _api) => super.noSuchMethod(Invocation.setter(#api, _api),
      returnValueForMissingStub: null);
  @override
  String get wsURL =>
      (super.noSuchMethod(Invocation.getter(#wsURL), returnValue: '')
          as String);
  @override
  set wsURL(String? _wsURL) =>
      super.noSuchMethod(Invocation.setter(#wsURL, _wsURL),
          returnValueForMissingStub: null);
  @override
  _i4.Future<_i2.Response> createUser(
          String? name, String? email, String? password) =>
      (super.noSuchMethod(
              Invocation.method(#createUser, [name, email, password]),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> authenticate(String? email, String? password) =>
      (super.noSuchMethod(Invocation.method(#authenticate, [email, password]),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> forgotUser(String? email) =>
      (super.noSuchMethod(Invocation.method(#forgotUser, [email]),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> retrieveUser(String? hash, String? password) =>
      (super.noSuchMethod(Invocation.method(#retrieveUser, [hash, password]),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> updateUser(String? id, String? name, String? email,
          String? password, String? jwt) =>
      (super.noSuchMethod(
              Invocation.method(#updateUser, [id, name, email, password, jwt]),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> deleteUser(String? id, String? jwt) =>
      (super.noSuchMethod(Invocation.method(#deleteUser, [id, jwt]),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> listUser(String? id, String? jwt) =>
      (super.noSuchMethod(Invocation.method(#listUser, [id, jwt]),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i4.Future<_i2.Response>);
  @override
  void changeServiceConnection(bool? https, String? host, String? port) =>
      super.noSuchMethod(
          Invocation.method(#changeServiceConnection, [https, host, port]),
          returnValueForMissingStub: null);
}
