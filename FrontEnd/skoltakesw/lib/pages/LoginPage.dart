import 'package:flutter/material.dart';
import 'package:skoltakesw/customModules/CustomElevatedButton.dart';
import 'package:skoltakesw/customModules/CustomTextInput.dart';
import 'package:skoltakesw/customFunctions/Login.dart';
import 'package:skoltakesw/customModules/popup.dart';
import 'package:skoltakesw/pages/Home.dart';
import 'package:skoltakesw/pages/SignUpPage.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";

  void updateEmail(String em) {
    setState(() {
      email = em;
    });
  }

  void updatePassword(String pw) {
    setState(() {
      password = pw;
    });
  }

  // setting and updating the password

  Future<void> loginCheck() async {
    /*
    * Giving the popup messages when having the errors or mistakes by the user's side
    * */
    if (email == "" && password == "") {
      new PopUp(
        title: "Fill the form",
        message: "You have to fill the form to login",
      ).build(context);
    } else if (email == "") {
      new PopUp(
        title: "Empty username",
        message: "You have to fill your email/username in the username section",
      ).build(context);
    } else if (password == "") {
      new PopUp(
        title: "Empty password",
        message: "You have to fill your password in the password section",
      ).build(context);
    } else {
      Response response = await login(email, password);
      if (response.statusCode == 404) {
        new PopUp(
          title: "User Not Found",
          message: "The username you have provided is wrong",
        ).build(context);
      } else if (response.statusCode == 406) {
        new PopUp(
          title: "Wrong Password",
          message: "The password you entered is wrong",
        ).build(context);
      } else {
        String userId = response.body.toString();
        saveUserData(userId);
        // saving the user data

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(userId)));
        // redirecting the user to the home page

      }
    }
  }

  Widget signInButtonChild = const Text(
    "Sign In",
    style: TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Widget button = CustomElevatedButton(
      signInButtonChild,
      () {
        setState(() {
          signInButtonChild = SpinKitPulse(
            color: Colors.white,
            size: 18,
          );
        });
        loginCheck().then((value) {
          setState(() {
            signInButtonChild = const Text(
              "Sign In",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            );
          });
        });
      },
      backgroundColor: (Colors.amber),
      textColor: Colors.white,
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black87,
          // setting the background color

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 11,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Skol",
                      style: TextStyle(
                        fontSize: 58,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // top title card

              const SizedBox(
                height: 20,
              ),

              Column(
                children: [
                  Form(
                    child: Column(
                      children: [
                        CustomTextInput(
                          "Username",
                          Icons.person,
                          updateEmail,
                        ),
                        CustomTextInput("Password", Icons.lock, updatePassword,
                            isPassword: true),
                        // email and password input field

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: button,
                        ),
                        // sign in button
                      ],
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text(
                      "Sign up.",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  // Redirection to the sign up page
                ],
              ),
              // The Sign in Form
            ],
          ),
        ),
      ),
    );
  }
}
