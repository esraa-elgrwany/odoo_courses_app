import 'dart:convert';
import 'dart:typed_data';
import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:courses_app/features/home/data/models/get_courses_model.dart';
import 'package:courses_app/features/home/presentation/view/widgets/edit_phone_row.dart';
import 'package:courses_app/features/home/presentation/view/widgets/editable_field.dart';
import 'package:courses_app/features/home/presentation/view/widgets/gender_row.dart';
import 'package:courses_app/features/home/presentation/view/widgets/payment_row.dart';
import 'package:courses_app/features/home/presentation/view/widgets/state_row.dart';
import 'package:courses_app/features/home/presentation/view/widgets/work_row.dart';
import 'package:courses_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:courses_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/know_us_row.dart';
import '../widgets/status_row.dart';

class CourseDetailsScreen extends StatefulWidget {
  static const String routeName = "courseDetailsScreen";

  const CourseDetailsScreen({super.key});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  late CoursesResult args;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController paymentController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController knowUsController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as CoursesResult;
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? bytes;
    if (args.gradImage != null && args.gradImage!.isNotEmpty) {
      try {
        bytes = base64Decode(args.gradImage!);
      } catch (_) {}
    }

    return BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is EditCoursesError) {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.grey[200],
                title: Text("Error", style: TextStyle(color: primaryColor)),
                content: Text(state.failure.errormsg, style: TextStyle(color: primaryColor)),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Okay", style: TextStyle(color: Colors.white))),
                ],
              ),
            );
          } else if (state is EditCoursesLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator(color:Colors.green,)),
            );
          } else if (state is EditCoursesSuccess) {
            Navigator.of(context).pop();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Center(
                    child: Text(
                      "Course Edited Successfully",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 4),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                ),
              );
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            surfaceTintColor: Colors.transparent,
            title: Text(AppLocalizations.of(context)!.courseDetails,style: TextStyle(
            fontSize: 24.sp,fontWeight: FontWeight.bold
            )),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (bytes != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(bytes, width: double.infinity, height: 240.h, fit: BoxFit.cover),
                  )
                else
                  const Icon(Icons.image_not_supported, size: 60),
                SizedBox(height: 16.h),
                EditableField(
                  controller: nameController,
                  label: AppLocalizations.of(context)!.name,
                  iconPath: "assets/images/id-card_6785365.png",
                  initialValue: args.name ?? "",
                  onSave: (value) {
                    context.read<HomeCubit>().editCourse(courseId: args.id!, name: nameController.text);
                  },
                ),
                SizedBox(height: 12.h,),
                CoursePhoneRow(args: args, controller: phoneController),
                SizedBox(height: 12.h,),
                EditableField(
                  controller: ageController,
                  label: AppLocalizations.of(context)!.age,
                  iconPath: "assets/images/calendar_3941031.png",
                  initialValue: args.age?.toString() ?? "",
                  keyboardType: TextInputType.number,
                  onSave: (value) {
                    context.read<HomeCubit>().editCourse(courseId: args.id!, age: int.tryParse(ageController.text));
                  },
                ),
                SizedBox(height: 12.h,),
                EditableField(
                  controller: cityController,
                  label: AppLocalizations.of(context)!.city,
                  iconPath: "assets/images/city_9087077.png",
                  initialValue: args.city ?? "",
                  onSave: (value) {
                    context.read<HomeCubit>().editCourse(courseId: args.id!, city: cityController.text);
                  },
                ),
                SizedBox(height: 12.h,),
                EditableField(
                  controller: batchController,
                  label: AppLocalizations.of(context)!.batchNum,
                  iconPath: "assets/images/ranking_1199434.png",
                  initialValue: (args.batchNum ?? 0).toString(),
                  onSave: (value) {
                    context.read<HomeCubit>().editCourse(courseId: args.id!, batchNum: int.tryParse(batchController.text));
                  },
                ),
                SizedBox(height: 12.h,),
                EditableField(
                  controller: noteController,
                  label: "note",
                  iconPath: "assets/images/memo_17641336.png",
                  initialValue: args.note ?? "",
                  onSave: (value) {
                    context.read<HomeCubit>().editCourse(courseId: args.id!, note: noteController.text);
                  },
                ),
                SizedBox(height: 12.h,),
                StateRow(
                  iconPath: "assets/images/map_3270996.png",
                  label: AppLocalizations.of(context)!.state,
                  initialValue: args.stateId?[1] ?? "",
                  onSave: (state) {
                    context.read<HomeCubit>().editCourse(courseId: args.id!, stateId: state.id);
                  },
                ),
                StatusRow(
                  iconPath: "assets/images/status_4727553.png",
                  label: AppLocalizations.of(context)!.status,
                  initialValue: args.status?[1] ?? "",
                  onSave: (state) {
                    context.read<HomeCubit>().editCourse(courseId: args.id!, status: state.id);
                  },
                ),
               KnowUsRow(
                  iconPath: "assets/images/business_1732637.png",
                  label: AppLocalizations.of(context)!.know,
                  initialValue: args.howKnowUs?[1] ?? "",
                  onSave: (knowUs) {
                    context.read<HomeCubit>().editCourse(courseId: args.id!, knowUs: knowUs.id);
                  },
                ),
                PaymentRow(args: args),
                GenderRow(args: args),
                WorkRow(args: args),
                SizedBox(height: 12.h,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Container(
                        height: 40.h,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: secondPrimary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Image.asset("assets/images/calendar_12354235.png", width: 24.w, height: 24.h),
                            SizedBox(width: 4.w),
                            Text("booking responsible", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        args.bookingResponsable?[1] ?? "no data",
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

