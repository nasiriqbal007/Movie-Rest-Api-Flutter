import 'package:flutter/material.dart';

Widget customImageLoadingBuilder(
    BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
  if (loadingProgress == null) {
    return child;
  } else {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Icon(
          Icons.image,
          color: Colors.grey,
        ),
      ),
    );
  }
}

Widget customImageErrorBuilder(
    BuildContext context, Object error, StackTrace? stackTrace) {
  return const Center(
    child: Icon(
      Icons.error,
      color: Colors.red,
    ),
  );
}
