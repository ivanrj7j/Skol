import 'package:flutter/material.dart';
import 'package:skoltakesw/customModules/CustomElevatedButton.dart';
import 'package:skoltakesw/customModules/CustomTextInput.dart';
import 'package:skoltakesw/customFunctions/SignUp.dart';
import 'package:skoltakesw/customModules/popup.dart';
import 'package:skoltakesw/pages/Home.dart';
import 'package:skoltakesw/pages/LoginPage.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../customFunctions/Login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String email = "";
  String username = "";
  String password = "";

  void updateEmail(String em) {
    setState(() {
      email = em;
    });
  }

  void updateUsername(String un) {
    setState(() {
      username = un;
    });
  }

  void updatePassword(String pw) {
    setState(() {
      password = pw;
    });
  }
  // initialising and updating the userdata

  Future<void> SignUpUser() async {
    /*
    * Giving the popup messages when having the errors or mistakes by the user's side
    * */
    if (email == "" && password == "" && username == "") {
      new PopUp(
        title: "Fill the form",
        message: "You have to fill the form to Sign up",
      ).build(context);
    } else if (username == "") {
      new PopUp(
        title: "Empty username",
        message: "You have to fill your username in the username section",
      ).build(context);
    } else if (email == "") {
      new PopUp(
        title: "Empty email",
        message: "You have to fill your email in the email section",
      ).build(context);
    } else if (password == "") {
      new PopUp(
        title: "Empty password",
        message: "You have to fill your password in the password section",
      ).build(context);
    } else {
      Response response = await SignUp(username, email, password);
      if (response.statusCode == 200) {
        saveUserData(response.body.toString());
        // saving the user's data

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(response.body.toString())));
        // redirecting the user to the homepage

      } else {
        new PopUp(
                title: "Something went Wrong",
                message: "Something went wrong, we will be fixing that soon")
            .build(context);
        // giving an error message
      }
    }
  }

  Widget signUpButtonChild = const Text(
    "Sign Up",
    style: TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Widget signUpButton = CustomElevatedButton(
      signUpButtonChild,
      () {
        setState(() {
          signUpButtonChild = SpinKitPulse(
            color: Colors.white,
            size: 18,
          );
        });
        SignUpUser().then((value) {
          signUpButtonChild = const Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          );
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

          child: ListView(
            children: [
              Column(
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
                          "Sign up",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // top title card thing

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
                            CustomTextInput(
                                "Email", Icons.email, updateUsername),
                            CustomTextInput(
                                "Password", Icons.lock, updatePassword,
                                isPassword: true),
                            // email, username and password fields

                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: signUpButton,
                            ),
                            // signup button
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text(
                          "Sign in.",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      // Redirection to sign in page
                    ],
                  ),
                  // Sign Up form
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
