import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:flutter/material.dart';

class TextFormItem extends StatelessWidget {
  final TextEditingController controller;
  String hint;
  String validateTxt;
  int maxLine;
  IconData icon;
  TextFormItem(
      {required this.controller,
      required this.hint,
      required this.validateTxt,required this.maxLine,required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      maxLines: maxLine,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            color: thirdPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        filled: true,
        fillColor: secondPrimary,
        suffixIcon: Icon(
         icon,
          color: primaryColor
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: secondPrimary,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: secondPrimary)),
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
