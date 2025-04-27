import 'dart:async';
import 'package:courses_app/core/cache/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../auth/presentation/view/login_screen.dart';
import '../home/presentation/view/screens/home_screen.dart';

class SplashScreen extends StatefulWidget{
  static const String routeName="splashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    String start;
    int? userId = CacheData.getData(key: "userId");
    if (userId == null) {
      start = LoginScreen.routeName;
    } else {
      start =HomeScreen.routeName;
    }
    Timer(Duration(seconds:5), () {
      Navigator.pushReplacementNamed(context, start);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/course splash.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Image.asset(
                    "assets/images/شريف زناتى since 2010 white 1.png",
                    width: 240,
                    height: 240.h,
                  ),
                ),
              ]),
        ));
  }
}
