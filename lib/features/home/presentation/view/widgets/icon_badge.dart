import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconBadge extends StatelessWidget {
  String img;

  IconBadge({required this.img});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.blue[50],
      child: Image.asset(
        img,
        width: 50.w,
        height: 50.h,
      ),
    );
  }
}
