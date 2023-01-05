import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  late ImageProvider profilePicture, postImage;
  late String username, community, caption, url, textContent, userDataString;
  late int points, comments, postType;
  late bool upvoted, downvoted;
  PostPage({
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
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
