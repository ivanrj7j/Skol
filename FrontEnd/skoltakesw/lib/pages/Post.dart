import 'package:flutter/material.dart';
import 'package:skoltakesw/customModules/PostCard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:skoltakesw/customFunctions/fileOps.dart';

class PostPage extends StatefulWidget {
  late ImageProvider profilePicture, postImage;
  late String username, community, caption, url, textContent, userDataString;
  late int points, comments, postType;
  late bool upvoted, downvoted;

  List<PostCard> posts = [];
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
  void getPosts() async {
    String host = await getHost();
    http.Response data =
        await http.post(Uri.parse('$host/getPosts'), body: {'noOfPosts': '5'});
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
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.posts.toString());
    PostContent card = PostContent(
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
      upvoted: widget.upvoted,
      downvoted: widget.downvoted,
    );
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
    // a method to upvote the post

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
    // a method to downvote the post

    List<Widget> voteButtons = card.voteButton(upvote, downvote);
    Widget postInfo = Container();

    if (widget.postType == 1) {
      if (widget.textContent != "") {
        postInfo = card.createTextPost(voteButtons[0], voteButtons[1]);
        // textpost
      } else {
        postInfo = card.createTitlePost(voteButtons[0], voteButtons[1]);
        // title only post
      }
    } else if (widget.postType == 2) {
      postInfo = card.createImagePost(voteButtons[0], voteButtons[1]);
      // post with image
    }

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          postInfo,
          Expanded(
              child: ListView(
            children: widget.posts,
          )),
        ],
      )),
      backgroundColor: const Color(0xFF242323),
    );
  }
}
