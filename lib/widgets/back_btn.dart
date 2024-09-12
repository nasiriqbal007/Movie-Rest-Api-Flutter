import "package:flutter/material.dart";

class BackBtn extends StatelessWidget {
  const BackBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, top: 20),
      decoration: const BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadiusDirectional.all(Radius.circular(12))),
      height: 70,
      width: 70,
      child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white70,
          )),
    );
  }
}
