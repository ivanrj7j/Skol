import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:skoltakesw/customFunctions/fileOps.dart';
import 'package:skoltakesw/customModules/CustomElevatedButton.dart';
import 'package:skoltakesw/customModules/PostCard.dart';

import 'Home.dart';

class ViewUser extends StatefulWidget {
  String userID;
  String name = "";
  String id = "";
  String username = "";
  String imageURL = "";
  String userDataString;
  List<PostCard> posts = [];
  ViewUser({super.key, required this.userID, required this.userDataString});

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  void getData() async {
    String host = await getHost();
    http.Response data =
        await http.get(Uri.parse('$host/getUserInfo?userID=${widget.userID}'));
    Map jsonData = json.decode(data.body);
    setState(() {
      widget.name = jsonData['name'];
      widget.id = jsonData['id'];
      widget.username = jsonData['username'];
      widget.imageURL = jsonData['imageURL'];
    });
    getPosts(json.encode(jsonData['posts']), host);
  }

  void getPosts(String postsList, String host) async {
    http.Response data = await http
        .post(Uri.parse('$host/getPostData'), body: {'posts': postsList});
    List<dynamic> jsonData = json.decode(data.body);
    List<PostCard> PostCardList = [];
    jsonData.forEach((element) {
      PostCardList.add(
          BuildPostCard(json.encode(element), widget.userDataString));
    });

    setState(() {
      widget.posts = PostCardList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Color(0xFF171515),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF0d0c0c),
              blurRadius: 24,
              spreadRadius: 7,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(widget.userDataString)))
              },
              icon: const Icon(
                Icons.home_sharp,
                color: Color(0xFFf1a40a),
              ),
              iconSize: 40,
            ),
            IconButton(
              onPressed: () => {},
              icon: const Icon(
                Icons.search_sharp,
                color: Color(0xFFe7e5d3),
              ),
              iconSize: 40,
            ),
            IconButton(
              onPressed: () => {},
              icon: const Icon(
                Icons.add_circle_outlined,
                color: Color(0xFFfad974),
              ),
              iconSize: 60,
            ),
            IconButton(
              onPressed: () => {},
              icon: const Icon(
                Icons.notifications,
                color: Color(0xFFe7e5d3),
              ),
              iconSize: 40,
            ),
            IconButton(
              onPressed: () => {},
              icon: const Icon(
                Icons.people_alt_sharp,
                color: Color(0xFFe7e5d3),
              ),
              iconSize: 40,
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF242323),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 450,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  color: Color(0xFF211f1f),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF0d0c0c),
                      blurRadius: 24,
                      spreadRadius: 7,
                    )
                  ]),
              child: Column(
                children: [
                  const SizedBox(
                    height: 45,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          )),
                      Text(
                        widget.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontFamily: "Dosis",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz_rounded,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  CircleAvatar(
                    foregroundImage: NetworkImage(widget.imageURL),
                    radius: 65,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '@${widget.username}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: "Dosis",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Active Communities',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: "Dosis",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Memes, CursedComments',
                    style: TextStyle(
                      color: Color(0xFFeee5e5),
                      fontSize: 16,
                      fontFamily: "Dosis",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomElevatedButton(
                          Container(
                            width: 80,
                            child: const Icon(
                              Icons.message_rounded,
                              color: Colors.white,
                            ),
                          ),
                          () {},
                          backgroundColor: const Color(0xFFffc516)),
                      CustomElevatedButton(
                          Container(
                            width: 80,
                            child: const Icon(
                              Icons.person_add,
                              color: Colors.white,
                            ),
                          ),
                          () {},
                          backgroundColor: const Color(0xFFffc516)),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: widget.posts,
            ))
          ],
        ),
      ),
    );
  }
}
