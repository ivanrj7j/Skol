import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerWidget extends StatelessWidget {
  double   width, height;
  ShapeBorder shape;
  ShimmerWidget.rectangle({super.key, required this.width, required this.height, this.shape=const RoundedRectangleBorder()});
  ShimmerWidget.circle({super.key, required this.width, required this.height, this.shape=const CircleBorder()});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(baseColor: const Color(0xFFe6dad9), highlightColor: const Color(0xFFfdfdfc),child: Container(
      width: this.width,
      height: this.height,
      decoration: ShapeDecoration(
        shape: this.shape,
        color: Colors.black87,
      ),
    ),);
  }
}
