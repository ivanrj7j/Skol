import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skoltakesw/customModules/shimmerwidget.dart';
import 'package:skoltakesw/pages/ViewUser.dart';

import '../customFunctions/socialPoints.dart';

class PlaceholderPost extends StatefulWidget {
  PlaceholderPost({Key? key}) : super(key: key);

  Widget currentState = Padding(
    padding: const EdgeInsets.all(23),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ShimmerWidget.circle(width: 54, height: 54),
                // poster pfp
                Padding(
                  padding: const EdgeInsets.all(3.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerWidget.rectangle(width: 116, height: 25),
                      const SizedBox(height: 1),
                      ShimmerWidget.rectangle(width: 60, height: 15)
                      // username and name
                    ],
                  ),
                )
              ],
            ),
            ShimmerWidget.rectangle(
              width: 5,
              height: 25,
            ),
            // 3 dots
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerWidget.rectangle(width: double.infinity, height: 10),
            const SizedBox(height: 1),
            ShimmerWidget.rectangle(width: double.infinity, height: 10),
            const SizedBox(height: 1),
            ShimmerWidget.rectangle(width: 30, height: 10),
          ],
        ),
        // text caption
        const SizedBox(
          height: 10,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ShimmerWidget.rectangle(width: double.infinity, height: 200),
        ),
        // main image
        const SizedBox(
          height: 6,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerWidget.rectangle(width: 70, height: 20),
              // vote
              ShimmerWidget.rectangle(width: 20, height: 20),
              // comments
              ShimmerWidget.rectangle(width: 25, height: 20),
              // share
            ],
          ),
        )
      ],
    ),
  );

  @override
  State<PlaceholderPost> createState() => _PlaceholderPostState();
}

class _PlaceholderPostState extends State<PlaceholderPost> {
  @override
  Widget build(BuildContext context) {
    return widget.currentState;
  }
}

class PostCard extends StatefulWidget {
  late ImageProvider profilePicture, postImage;
  late String username, community, caption, url, textContent, userDataString;
  late int points, comments, postType;
  late bool upvoted, downvoted;
  PostCard({
    Key? key,
    required this.profilePicture,
    required this.username,
    required this.community,
    required this.caption,
    required this.url,
    required this.points,
    required this.comments,
    required this.postImage,
    required this.textContent,
    required this.userDataString,
    this.upvoted = false,
    this.downvoted = false,
    this.postType = 2,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    void upvote() {
      setState(() {
        widget.upvoted = !widget.upvoted;
        if (widget.upvoted) {
          widget.points += 1;
        } else {
          widget.points -= 1;
        }
        if (widget.upvoted && widget.downvoted) {
          widget.downvoted = false;
          widget.points += 1;
        }
      });
    }

    void downvote() {
      setState(() {
        widget.downvoted = !widget.downvoted;
        if (widget.downvoted) {
          widget.points -= 1;
        } else {
          widget.points += 1;
        }
        if (widget.upvoted && widget.downvoted) {
          widget.upvoted = false;
          widget.points -= 1;
        }
      });
    }

    Widget upvoteButton = IconButton(
        onPressed: upvote,
        icon: const Icon(CupertinoIcons.arrowtriangle_up_fill),
        color: const Color(0xFF9d9999));

    Widget downvoteButton = IconButton(
        onPressed: downvote,
        icon: const Icon(CupertinoIcons.arrowtriangle_down_fill),
        color: const Color(0xFF9d9999));

    if (widget.upvoted) {
      upvoteButton = IconButton(
          onPressed: upvote,
          icon: const Icon(CupertinoIcons.arrowtriangle_up_fill),
          color: const Color(0xFFffc516));
    }

    if (widget.downvoted) {
      downvoteButton = IconButton(
          onPressed: downvote,
          icon: const Icon(CupertinoIcons.arrowtriangle_down_fill),
          color: const Color(0xFF2fa7fb));
    }

    void onTapFunction() {
      print("hi");
    }

    Widget imagePost = Padding(
      padding: const EdgeInsets.fromLTRB(7, 20, 7, 2),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF211f1f),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF0d0c0c),
              blurRadius: 24,
              spreadRadius: 7,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: widget.profilePicture,
                        radius: 27,
                        backgroundColor: const Color(0xFFfedc76),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewUser(
                                              userID: widget.username,
                                              userDataString:
                                                  widget.userDataString,
                                            )));
                              },
                              child: Text(
                                widget.username.characters.take(12).toString(),
                                style: const TextStyle(
                                    fontFamily: "Dosis",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                    color: Colors.white),
                              ),
                            ),
                            Text(
                              widget.community,
                              style: const TextStyle(
                                  fontFamily: "Dosis",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.more_vert_sharp),
                    color: const Color(0xFFfedc76),
                    iconSize: 29,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.caption,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: widget.postImage,
                  width: double.infinity,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return ShimmerWidget.rectangle(
                        width: double.infinity, height: 200);
                  },
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        upvoteButton,
                        Text(
                          convertToString(widget.points),
                          style: const TextStyle(
                              color: Colors.white, fontFamily: "Dosis"),
                        ),
                        downvoteButton,
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            style: BorderStyle.solid,
                            color: const Color(0xFF9d9999)),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        convertToString(widget.comments),
                        style: const TextStyle(
                          color: Color(0xFFffffff),
                          fontFamily: "Dosis",
                        ),
                      ),
                    ),
                    const Text(
                      "Share!",
                      style: TextStyle(
                        color: Color(0xFFf0d070),
                        fontFamily: "Dosis",
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

    Widget textPost = Padding(
      padding: const EdgeInsets.fromLTRB(7, 20, 7, 2),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF211f1f),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF0d0c0c),
              blurRadius: 24,
              spreadRadius: 7,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: widget.profilePicture,
                        radius: 27,
                        backgroundColor: const Color(0xFFfedc76),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewUser(
                                              userID: widget.username,
                                              userDataString:
                                                  widget.userDataString,
                                            )));
                              },
                              child: Text(
                                widget.username.characters.take(12).toString(),
                                style: const TextStyle(
                                    fontFamily: "Dosis",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                    color: Colors.white),
                              ),
                            ),
                            Text(
                              widget.community,
                              style: const TextStyle(
                                  fontFamily: "Dosis",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.more_vert_sharp),
                    color: const Color(0xFFfedc76),
                    iconSize: 29,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.caption,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.textContent,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        upvoteButton,
                        Text(
                          convertToString(widget.points),
                          style: const TextStyle(
                              color: Colors.white, fontFamily: "Dosis"),
                        ),
                        downvoteButton,
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            style: BorderStyle.solid,
                            color: const Color(0xFF9d9999)),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        convertToString(widget.comments),
                        style: const TextStyle(
                          color: Color(0xFFffffff),
                          fontFamily: "Dosis",
                        ),
                      ),
                    ),
                    const Text(
                      "Share!",
                      style: TextStyle(
                        color: Color(0xFFf0d070),
                        fontFamily: "Dosis",
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

    Widget titlePost = Padding(
      padding: const EdgeInsets.fromLTRB(7, 20, 7, 2),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF211f1f),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF0d0c0c),
              blurRadius: 24,
              spreadRadius: 7,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: widget.profilePicture,
                        radius: 27,
                        backgroundColor: const Color(0xFFfedc76),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewUser(
                                              userID: widget.username,
                                              userDataString:
                                                  widget.userDataString,
                                            )));
                              },
                              child: Text(
                                widget.username.characters.take(12).toString(),
                                style: const TextStyle(
                                    fontFamily: "Dosis",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                    color: Colors.white),
                              ),
                            ),
                            Text(
                              widget.community,
                              style: const TextStyle(
                                  fontFamily: "Dosis",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.more_vert_sharp),
                    color: const Color(0xFFfedc76),
                    iconSize: 29,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.caption,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        upvoteButton,
                        Text(
                          convertToString(widget.points),
                          style: const TextStyle(
                              color: Colors.white, fontFamily: "Dosis"),
                        ),
                        downvoteButton,
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            style: BorderStyle.solid,
                            color: const Color(0xFF9d9999)),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        convertToString(widget.comments),
                        style: const TextStyle(
                          color: Color(0xFFffffff),
                          fontFamily: "Dosis",
                        ),
                      ),
                    ),
                    const Text(
                      "Share!",
                      style: TextStyle(
                        color: Color(0xFFf0d070),
                        fontFamily: "Dosis",
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

    if (widget.postType == 1) {
      if (widget.textContent != "") {
        return InkWell(onTap: onTapFunction, child: textPost);
      } else {
        return InkWell(onTap: onTapFunction, child: titlePost);
      }
    } else if (widget.postType == 2) {
      return InkWell(onTap: onTapFunction, child: imagePost);
    } else {
      return Container();
    }
  }
}

PostCard BuildPostCard(String postData, String userDataString) {
  Map<String, dynamic> data = json.decode(postData);
  String name = data['name'];
  String username = data['username'];
  int postType = data['postType'];
  String caption;
  NetworkImage postImage, pfp;
  pfp = NetworkImage(data['pfp']);
  String url = data['url'];
  int points = data['points'];
  int comments = data['comments'];
  String textContent = "";
  if (postType == 1) {
    textContent = data['media'];
  }

  if (postType == 1) {
    caption = data['caption'];
    postImage = pfp;
    return PostCard(
      profilePicture: pfp,
      username: name,
      community: username,
      caption: caption,
      url: url,
      points: points,
      comments: comments,
      postImage: postImage,
      postType: postType,
      textContent: textContent,
      userDataString: userDataString,
    );
  } else {
    caption = data['caption'];
    postImage = NetworkImage(data['filename']);
    return PostCard(
      profilePicture: pfp,
      username: name,
      community: username,
      caption: caption,
      url: url,
      points: points,
      comments: comments,
      postImage: postImage,
      textContent: textContent,
      userDataString: userDataString,
    );
  }
}
