import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldItem extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String hint;
  IconData icon;
  String validateTxt;

  TextFieldItem(
      {required this.controller,
      required this.hint,
      required this.icon,
      required this.validateTxt});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color:Colors.black,fontSize: 16.sp,fontWeight:FontWeight.w500),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color:thirdPrimary,fontSize: 16.sp,fontWeight:FontWeight.w500),
        filled: true,
        fillColor: secondPrimary,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: secondPrimary)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: secondPrimary)),
        prefixIcon: Icon(icon, color: primaryColor,size: 22,),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validateTxt;
        }
        return null;
      },
    );
  }
}
