import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:skoltakesw/customFunctions/fileOps.dart';

Future<Response> login(String email, String password) async {
  String host = await rootBundle.loadString("assets/host.txt");
  password = await asymmetricEncrypt(password);
  final response = await post(Uri.parse('$host/authenticate'), body: {
    "username": email,
    "password": password,
  });

  return response;
}

Future<void> saveUserData(String userData) async {
  String directory = await getDirectory();

  String previousData = "";
  File userSaveFile = File("$directory/userData.txt");

  if (await userSaveFile.exists()) {
    previousData = await userSaveFile.readAsString();
  }

  userSaveFile.writeAsString(userData);
}

Future<String> loadUserData() async {
  String path = await getDirectory();
  File userSaveFile = File("$path/userData.txt");
  if (!await userSaveFile.exists()) {
    return "";
  } else {
    String userId = await userSaveFile.readAsString();
    return userId;
  }
}
