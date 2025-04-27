import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  String routeName;

  FloatingButton(this.routeName);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(30)),
      backgroundColor: primaryColor,
      onPressed: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Icon(
        Icons.add,
        size: 32,
        color: Colors.white,
      ),
    );
  }
}
