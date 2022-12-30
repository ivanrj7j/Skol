import 'package:http/http.dart';
import 'fileOps.dart';
import 'Login.dart';
import 'dart:convert';



Future<List<dynamic>> fetchPosts() async{
  String host = await getHost();
  // getting the host

  String user = jsonDecode(await loadUserData())["userID"];
  // getting the username

  String url = "$host/getPosts";
  final response = await post(Uri.parse(url), body: {
    "userID": user,
    "noOfPosts" : 3.toString()
  });


  return jsonDecode(response.body);
}