import 'package:courses_app/features/home/presentation/view/widgets/icon_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../setting/model_view/setting_cubit.dart';
import '../../view_model/home_cubit.dart';
class TaskCard extends StatelessWidget{
  int index;
   TaskCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final tasks = HomeCubit.get(context).tasks;

    if (tasks.isEmpty || index < 0 || index >= tasks.length) {
      return SizedBox();
    }

    final task = tasks[index]; // Now it's safe to access
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          child: Card(
            color: Theme.of(context).colorScheme.onBackground,
            elevation: 4,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(task.name ?? "No name",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Image.asset("assets/images/project.png",width:24.w,height: 24.h,),
                        SizedBox(width: 4.w,),
                        Text(
                            task.projectId ??"No Project" ,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                               )),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Image.asset("assets/images/partner.png",width:28.w,height: 28.h,),
                        SizedBox(width: 4.w,),
                        Flexible(
                          flex:14,
                          child: Column(
                            children: [
                              Text(task.partnerId?? "No customer",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  )
                                      ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Text("stage: ",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        Text(task.stage??"no stage",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
            alignment: SettingCubit.get(context).isArabic? Alignment.centerLeft: Alignment.topRight,
            child: IconBadge(
              img: "assets/images/check-list.png",
            )),
      ],
    );
  }
}
