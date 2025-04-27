import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:flutter/material.dart';

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
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color:thirdPrimary,fontSize: 14),
        filled: true,
        fillColor: secondPrimary,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: secondPrimary)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: secondPrimary)),
        prefixIcon: Icon(icon, color: primaryColor,size: 20,),
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
