import 'package:users_client/uc/user_uc.dart';

void main(List<String> arguments) async {
  // The default instantiation of UsersClient is: http, localhost and 8080.
  // To change the http/https, host and port use changeServiceConnection method
  var client = UsersClient();
  await client.createUser('you name', 'youname@test.com', '12345678');
}
