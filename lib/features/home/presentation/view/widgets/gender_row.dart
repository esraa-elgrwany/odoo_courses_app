import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:courses_app/features/home/data/models/get_courses_model.dart';
import 'package:courses_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:courses_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderRow extends StatefulWidget{
  final CoursesResult args;

  const GenderRow({Key? key, required this.args}) : super(key: key);

  @override
  State<GenderRow> createState() => _GenderRowState();
}

class _GenderRowState extends State<GenderRow> {
  late String? selectedGender;
  late String? originalGender;
  bool hasChanged = false;

  @override
  void initState() {
    super.initState();
    originalGender = widget.args.gender;
    selectedGender = originalGender;
  }

  void _onGenderChanged(String? value) {
    if (value == null) return;
    setState(() {
      selectedGender = value;
      hasChanged = selectedGender != originalGender;
    });
  }

  void _saveGender() {
    if (selectedGender != null) {
      context.read<HomeCubit>().editCourse(
        courseId: widget.args.id!,
        gender: selectedGender!,
      );

      setState(() {
        originalGender = selectedGender;
        hasChanged = false;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              Image.asset("assets/images/gender_2102925.png", width: 24.w, height: 24.h),
              SizedBox(width: 4.w),
              Text(
                AppLocalizations.of(context)!.gender,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: "male",
                    groupValue: selectedGender,
                    onChanged: _onGenderChanged,
                  ),
                  Text(
                    AppLocalizations.of(context)!.male,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: "female",
                    groupValue: selectedGender,
                    onChanged: _onGenderChanged,
                  ),
                  Text(
                    AppLocalizations.of(context)!.female,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
              const Spacer(),
              if (hasChanged)
                InkWell(
                  onTap: _saveGender,
                  child: Icon(Icons.check, color: Colors.green, size: 24),
                ),
            ],
          ),
        ),
      ],
    );
  }
}