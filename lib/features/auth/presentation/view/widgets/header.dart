import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Header extends StatelessWidget {
  String txt1;
  String txt2;

  Header(this.txt1, this.txt2);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
            backgroundColor:Colors.blue[100],
            radius: 32,
            child:Image.asset("assets/images/login_12658121.png") ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              txt1,
              style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              txt2,
              style: TextStyle(color: Colors.grey,fontSize:18.sp,),
            ),
          ],
        ),
      ],
    );
  }
}
