import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:courses_app/features/auth/presentation/view/login_screen.dart';
import 'package:courses_app/features/home/presentation/view/widgets/home_card_item.dart';
import 'package:courses_app/features/setting/view/setting_screen.dart';
import 'package:courses_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/cache/shared_preferences.dart';
class HomeScreen extends StatefulWidget{
  static const String routeName="homeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        "title": AppLocalizations.of(context)!.courses,
        "image": "assets/images/course_card.png",
        "route":"courseScreen"
      },
      {
        "title": AppLocalizations.of(context)!.tasks,
        "image": "assets/images/task_card.png",
        "route":"taskScreen"
      },
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 160.h,
             width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/course splash.jpg"),fit: BoxFit.cover),
                  color: primaryColor,
                 borderRadius: BorderRadius.only(
                   bottomLeft: Radius.circular(50),
                   bottomRight: Radius.circular(50),
                 )
              ),
              child: Center(child: Image.asset("assets/images/شريف زناتى since 2010 white 1.png",width:100.w,height:130.h,
                fit: BoxFit.cover,)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:8.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text(
                              AppLocalizations.of(context)!.hello,
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(AppLocalizations.of(context)!.welcome,
                              style: TextStyle(
                                fontSize: 16.sp,

                              )),
                          ],
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, SettingScreen.routeName);
                        }, icon:Icon(Icons.settings,size:32.sp,),color: Colors.black,),
                    ],
                  ),
                  SizedBox(height:8.h),
                  Container(
                    height: MediaQuery.of(context).size.height/2,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:2,
                        childAspectRatio:.9,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: menuItems.length,
                      itemBuilder: (context, index) {
                        return HomeCardItem(
                          imageUrl: menuItems[index]["image"],
                          title: menuItems[index]["title"],
                          route:menuItems[index]["route"] ,);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
