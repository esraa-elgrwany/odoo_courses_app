import 'package:flutter/material.dart';

class IconBadge extends StatelessWidget {
  String img;

  IconBadge({required this.img});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 26,
      backgroundColor: Colors.blue[50],
      child: Image.asset(
        img,
        width: 48,
        height: 48,
      ),
    );
  }
}
