import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:skoltakesw/customFunctions/fetchPosts.dart';
import 'package:skoltakesw/customModules/shimmerwidget.dart';
import '../customFunctions/fileOps.dart';
import '../customModules/PostCard.dart';
import 'package:skoltakesw/customModules/gradientText.dart';
import 'package:http/http.dart' as http;
import '../customModules/storyAvatar.dart';
import 'dart:async';

class Home extends StatefulWidget {
  late Map<String, dynamic> userData;

  Home(String dataString) {
    userData = json.decode(dataString);
    // getting the userdata
  }
  List<PostCard> allPosts = [];
  bool isLoadingData = true;

  @override
  State<Home> createState() =>
      _HomeState(userData["email"], userData["userID"], userData['username']);
  // creating a new state
}

class _HomeState extends State<Home> {
  String email, userId, username;
  _HomeState(this.email, this.userId, this.username);
  // getting the user data

  Future<void> loadPosts() async {
    setState(() {
      widget.isLoadingData = true;
    });

    List<dynamic> data = await getPosts();

    setState(() {
      for (var i in data) {
        PostCard post = BuildPostCard(json.encode(i));
        widget.allPosts.add(post);
      }
    });

    setState(() {
      widget.isLoadingData = false;
    });
  }

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPosts();
    _scrollController.addListener(() {
      if (!widget.isLoadingData) loadPosts();
    });
  }

  Future<List> getPosts({int noOfPosts = 10}) async {
    String host = await getHost();
    //TODO: do with the user data
    http.Response data = await http.post(Uri.parse('$host/getPosts'),
        body: {'userID': '', 'noOfPosts': noOfPosts.toString()});
    List jsonData = await json.decode(data.body);
    return jsonData;
  }

  Future<void> refreshData() async {
    widget.allPosts = [];
    if (!widget.isLoadingData) await loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(27, 23, 27, 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      GradientText(
                        "Skol",
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFf5ab16),
                            Color(0xFFe8a215),
                            Color(0xFFcf9013),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        style: TextStyle(
                          fontSize: 44,
                          fontFamily: "Informal",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Skol title

                      CircleAvatar(
                        backgroundColor: Color(0xFFb77f11),
                        radius: 24,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/user.png"),
                          backgroundColor: Color(0xFFfedc76),
                          radius: 22,
                        ),
                        // Avatar
                      )
                    ],
                  ),
                  // Skol Title and User Button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: StoryAvatar(
                                  backgroundImage: const AssetImage(
                                      "assets/images/user.png"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: StoryAvatar(
                                  backgroundImage: const AssetImage(
                                      "assets/images/user.png"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: StoryAvatar(
                                  backgroundImage: const AssetImage(
                                      "assets/images/user.png"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: StoryAvatar(
                                  backgroundImage: const AssetImage(
                                      "assets/images/user.png"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: StoryAvatar(
                                  backgroundImage: const AssetImage(
                                      "assets/images/user.png"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: StoryAvatar(
                                  backgroundImage: const AssetImage(
                                      "assets/images/user.png"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: StoryAvatar(
                                  backgroundImage: const AssetImage(
                                      "assets/images/user.png"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: StoryAvatar(
                                  backgroundImage: const AssetImage(
                                      "assets/images/user.png"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: StoryAvatar(
                                  backgroundImage: const AssetImage(
                                      "assets/images/user.png"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: StoryAvatar(
                                  backgroundImage: const AssetImage(
                                      "assets/images/user.png"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: StoryAvatar(
                                  backgroundImage: const AssetImage(
                                      "assets/images/user.png"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: StoryAvatar(
                                  backgroundImage: const AssetImage(
                                      "assets/images/user.png"),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          widget.isLoadingData
              ? Expanded(
                  child: RefreshIndicator(
                    backgroundColor: Colors.transparent,
                    color: const Color(0xFFffc516),
                    onRefresh: refreshData,
                    child: ListView(
                      controller: _scrollController,
                      children: [
                        for (Widget post in widget.allPosts) post,
                        PlaceholderPost(),
                        PlaceholderPost(),
                        PlaceholderPost()
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: RefreshIndicator(
                  backgroundColor: Colors.transparent,
                  color: const Color(0xFFffc516),
                  onRefresh: refreshData,
                  child: ListView(
                    controller: _scrollController,
                    children: widget.allPosts,
                  ),
                ))
        ],
      )),
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
                _scrollController.animateTo(
                    _scrollController.initialScrollOffset,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeIn)
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
    );
  }
}
