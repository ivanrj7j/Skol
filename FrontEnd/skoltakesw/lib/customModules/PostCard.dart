import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skoltakesw/customModules/shimmerwidget.dart';
import 'package:skoltakesw/pages/ViewUser.dart';
import 'package:skoltakesw/pages/Post.dart';
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

class PostContent extends StatelessWidget {
  late ImageProvider profilePicture, postImage;
  late String username, community, caption, url, textContent, userDataString;
  late int points, comments, postType;
  late bool upvoted, downvoted;
  BuildContext context;
  PostContent({
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
    required this.context,
    this.upvoted = false,
    this.downvoted = false,
    this.postType = 2,
  }) : super(key: key);

  Widget createImagePost(Widget upvoteButton, Widget downvoteButton) {
    return Padding(
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
                    backgroundImage: profilePicture,
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
                                          userID: username,
                                          userDataString: userDataString,
                                        )));
                          },
                          child: Text(
                            username.characters.take(12).toString(),
                            style: const TextStyle(
                                fontFamily: "Dosis",
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          community,
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
            caption,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: postImage,
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
                      convertToString(points),
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
                    convertToString(comments),
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
    );
  }
  // creates a postcard with image

  Widget createTextPost(Widget upvoteButton, Widget downvoteButton) {
    return Padding(
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
                    backgroundImage: profilePicture,
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
                                          userID: username,
                                          userDataString: userDataString,
                                        )));
                          },
                          child: Text(
                            username.characters.take(12).toString(),
                            style: const TextStyle(
                                fontFamily: "Dosis",
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          community,
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
            caption,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            textContent,
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
                      convertToString(points),
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
                    convertToString(comments),
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
    );
  }
  // creates a postcard with text and title

  Widget createTitlePost(Widget upvoteButton, Widget downvoteButton) {
    return Padding(
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
                    backgroundImage: profilePicture,
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
                                          userID: username,
                                          userDataString: userDataString,
                                        )));
                          },
                          child: Text(
                            username.characters.take(12).toString(),
                            style: const TextStyle(
                                fontFamily: "Dosis",
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          community,
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
            caption,
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
                      convertToString(points),
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
                    convertToString(comments),
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
    );
  }
  // creates a postcard with only title

  List<Widget> voteButton(void Function() upvote, void Function() downvote) {
    Widget upvoteButton = IconButton(
      onPressed: upvote,
      icon: const Icon(CupertinoIcons.arrowtriangle_up_fill),
      color: !upvoted ? const Color(0xFF9d9999) : const Color(0xFFffc516),
    );

    Widget downvoteButton = IconButton(
      onPressed: downvote,
      icon: const Icon(CupertinoIcons.arrowtriangle_down_fill),
      color: !downvoted ? const Color(0xFF9d9999) : const Color(0xFF2fa7fb),
    );
    return [upvoteButton, downvoteButton];
  }

  @override
  Widget build(BuildContext context) {
    return Container();
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
    PostContent content = PostContent(
      profilePicture: widget.profilePicture,
      username: widget.username,
      community: widget.community,
      caption: widget.caption,
      url: widget.url,
      points: widget.points,
      comments: widget.comments,
      postImage: widget.postImage,
      textContent: widget.textContent,
      userDataString: widget.userDataString,
      context: context,
      postType: widget.postType,
      upvoted: widget.upvoted,
      downvoted: widget.downvoted,
    );

    void upvote() {
      setState(() {
        content.upvoted = !content.upvoted;
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
    // a method to upvote the post

    void downvote() {
      setState(() {
        content.upvoted = !content.upvoted;
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
    // a method to downvote the post

    void onTapFunction() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostPage(
                    profilePicture: widget.profilePicture,
                    username: widget.username,
                    community: widget.community,
                    caption: widget.caption,
                    url: widget.url,
                    points: widget.points,
                    comments: widget.comments,
                    postImage: widget.postImage,
                    textContent: widget.textContent,
                    userDataString: widget.userDataString,
                    postType: widget.postType,
                  )));
    }

    Widget buildPostCard(Widget post) {
      return Padding(
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
          child: post,
        ),
      );
    }

    List<Widget> voteButtons = content.voteButton(upvote, downvote);
    if (widget.postType == 1) {
      if (widget.textContent != "") {
        return InkWell(
            onTap: onTapFunction,
            child: buildPostCard(
                content.createTextPost(voteButtons[0], voteButtons[1])));
        // textpost
      } else {
        return InkWell(
            onTap: onTapFunction,
            child: buildPostCard(
                content.createTitlePost(voteButtons[0], voteButtons[1])));
        // title only post
      }
    } else if (widget.postType == 2) {
      return InkWell(
          onTap: onTapFunction,
          child: buildPostCard(
              content.createImagePost(voteButtons[0], voteButtons[1])));
      // post with image
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
