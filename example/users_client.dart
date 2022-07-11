

import 'package:users_client/client/user_ws.dart';

void main(List<String> arguments) async {
  // false means http and true https
  var ws = UsersWebService(false);
  await ws.createUser('you name', 'youname@test.com', '12345678');
}