import 'dart:convert';
import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

Future<T> parseKeyFromFile<T extends RSAAsymmetricKey>(String filename) async {
  final key = await rootBundle.loadString(filename);
  final parser = RSAKeyParser();
  return parser.parse(key) as T;
}

Future<String> getDirectory() async{
  // /data/data/com.example.skol/app_flutter/userData
  Directory filePath = await getApplicationDocumentsDirectory();
  String directory = "userData";
  bool DirectoryExists = await Directory("${filePath.path}/$directory").exists();
  if(!DirectoryExists){
    await Directory("${filePath.path}/$directory").create(recursive: true);
  }
  // getting the directory path, creating a new one if it does not exists

  return "${filePath.path}/$directory";
}

Future<String> asymmetricEncrypt(String message) async{
  final publicKey = await parseKeyFromFile<RSAPublicKey>('assets/public_key.pem');
  final encryptor = await Encrypter(RSA(publicKey: publicKey, encoding: RSAEncoding.OAEP));
  return encryptor.encrypt(message).base64;
}

Future<String> getHost() async{
  String host = await rootBundle.loadString("assets/host.txt");
  return host;
}