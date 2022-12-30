import 'package:skoltakesw/customFunctions/fileOps.dart';
import 'package:http/http.dart';
import 'package:encrypt/encrypt.dart';
import 'package:skoltakesw/customFunctions/uniqueID.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<Response> SignUp(String username, String email, String password) async {
  password = await asymmetricEncrypt(password);
  String host = await rootBundle.loadString("assets/host.txt");
  final response = await post(Uri.parse('$host/register'), body: {
    "username": username,
    "email": email,
    "password": password,
    "id": getUserID(username),
  });

  return response;
}
