import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCardItem extends StatelessWidget{
  final String title;
  final String imageUrl;
  final String route;
   HomeCardItem({required this.title,required this.imageUrl,required this.route});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        Navigator.pushNamed(context,route);
      },
      child: Container(
        height: 260.h,
        child: Card(
          color: Theme.of(context).colorScheme.onBackground,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  imageUrl,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(height:16,),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
