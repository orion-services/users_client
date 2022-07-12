import 'package:users_client/uc/user_uc.dart';

void main(List<String> arguments) async {
  // The default instantiation of UserUC is: http, localhost and 8080.
  // To change the http/https, host and port use changeServiceConnection method
  var service = UserUC();
  await service.createUser('you name', 'youname@test.com', '12345678');
}
