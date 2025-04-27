import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:flutter/material.dart';

class DropDownContainer extends StatelessWidget{
  String text;
  DropDownContainer({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.secondary,
        border: Border.all(color:secondPrimary),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(color:Colors.black, fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          Spacer(),
          InkWell(
            onTap: () {
            },
              child: Icon(Icons.arrow_drop_down_circle_outlined,size:20,color: primaryColor)),
        ],
      ),
    );
  }
}
