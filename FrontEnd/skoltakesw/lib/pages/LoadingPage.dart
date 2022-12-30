import 'package:flutter/material.dart';
import 'package:skoltakesw/customFunctions/Login.dart';
import 'package:skoltakesw/pages/Home.dart';
import 'package:skoltakesw/pages/LoginPage.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = loadUserData().then((value) {
      if (value.isNotEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(value)));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
    return Container(
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(120),
        child: Center(
          child: Image.asset("assets/logo.png"),
        ),
      ),
    );
  }
}
