import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget{
  String txt;
  ButtonWidget({required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
      MediaQuery.of(context).size.width /
          1.6,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius:
          BorderRadiusDirectional
              .circular(12),
          color: primaryColor),
      child: Center(
          child: Text(
           txt,
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20.sp),
          )),
    );
  }
}
