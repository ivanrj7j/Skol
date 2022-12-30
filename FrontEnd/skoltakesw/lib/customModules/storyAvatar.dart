import 'package:flutter/material.dart';

class StoryAvatar extends StatelessWidget {
  late ImageProvider? backgroundImage;
  late Widget child;
  StoryAvatar({Key? key, this.backgroundImage, this.child=const Text("")}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: Color(0xFFb77f11),
    radius: 24,
    child: CircleAvatar(
    backgroundImage: backgroundImage,
    backgroundColor: Color(0xFFfedc76),
    radius: 22,
      child: child,
    ));
  }
}
