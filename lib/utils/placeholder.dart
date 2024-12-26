import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerPlaceholder({required double width, double height = 200}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[700]!,
    highlightColor: Colors.grey[800]!,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(9),
      ),
    ),
  );
}
