import 'package:courses_app/features/home/presentation/view/widgets/icon_badge.dart';
import 'package:courses_app/features/setting/model_view/setting_cubit.dart';
import 'package:courses_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/utils/styles/colors.dart';
import '../../view_model/home_cubit.dart';

class CourseCard extends StatelessWidget {
  int index;

  CourseCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final courses = HomeCubit.get(context).courses;

    if (courses.isEmpty || index >= courses.length) {
      return Center(
        child: Text(
          "No Course Available",
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      );
    }
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          child: Card(
            color: Theme.of(context).colorScheme.onBackground,
            elevation: 6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courses[index].name ?? "No Name",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // City
                  Row(
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.city}:",
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      //Image.asset("assets/images/cityscape_17359653.png",width:24,height:24,),
                      SizedBox(width: 6.w),
                      Text(
                        courses[index].city ?? "No City",
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // State
                  Row(
                    children: [
                      Text(
                  "${AppLocalizations.of(context)!.state}:",
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      //Image.asset("assets/images/partner.png",width:24,height:24,),
                      SizedBox(width: 6.w),
                      Text(
                        courses[index].stateId?[1] ?? "No State",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.date}:",
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        _formatDate(courses[index].date),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      Spacer(),
                      Icon(Icons.date_range_outlined,color:primaryColor,size: 28.sp,),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/money_14858977.png",
                        width: 26.w,
                        height: 26.h,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        courses[index].payMethod ?? "No Payment",
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      Spacer(),
                      BlocConsumer<HomeCubit, HomeState>(
                        listener: (context, state) {
                          if (state is DeleteCoursesError) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.grey[200],
                                title: Text(
                                  "Error",
                                  style: TextStyle(color: primaryColor),
                                ),
                                content: Text(
                                  state.failures.errormsg,
                                  style: TextStyle(color: primaryColor),
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("okay",
                                          style: TextStyle(
                                              color: Colors.white))),
                                ],
                              ),
                            );
                          } else if (state is DeleteCoursesSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Center(
                                    child: Text(
                                      "Course deleted successfully",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 4),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(24),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 4)),
                            );
                          }
                        },
                        builder: (context, state) {

                          return IconButton(
                              icon: Image.asset(
                                "assets/images/delete_8567757.png",
                                width: 26.w,
                                height: 26.h,
                              ),
                              onPressed: () => {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) =>
                                          AlertDialog(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        title: Text(AppLocalizations.of(context)!.deleteCourse),
                                        content: Text(
                                            AppLocalizations.of(context)!.areYouSureCourse),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(dialogContext),
                                            child: Text(AppLocalizations.of(context)!.cancel),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              HomeCubit.get(context)
                                                  .deleteCourse(
                                                      courseId: courses[index]
                                                              .id ??
                                                          0);
                                             // HomeCubit.get(context).getCourses();
                                              Navigator.pop(dialogContext);
                                            },
                                            child: Text(AppLocalizations.of(context)!.delete,
                                                style: TextStyle(
                                                    color: Colors.red)),
                                          ),
                                        ],
                                      ),
                                    )
                                  });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment:SettingCubit.get(context).isArabic? Alignment.centerLeft: Alignment.centerRight,
          child: IconBadge(
            img: "assets/images/course.png",
          ),
        ),
      ],
    );
  }
  String _formatDate(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) {
      return "No date";
    }
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      return "Invalid date";
    }
  }
}
