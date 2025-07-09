import 'package:courses_app/features/home/data/models/get_courses_model.dart';
import 'package:courses_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:courses_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/styles/colors.dart';

class WorkRow extends StatefulWidget{
  final CoursesResult args;

  const WorkRow({Key? key, required this.args}) : super(key: key);

  @override
  State<WorkRow> createState() => _WorkRowState();
}

class _WorkRowState extends State<WorkRow> {
  late String? selectedValue;
  late String? originalValue;
  bool hasChanged = false;

  @override
  void initState() {
    super.initState();
    originalValue = widget.args.workStatus?.toLowerCase(); // Correct initial value
    selectedValue = originalValue;
  }

  void _onStatusChanged(String? value) {
    if (value == null) return;
    setState(() {
      selectedValue = value;
      hasChanged = selectedValue != originalValue;
    });
  }

  void _saveStatus() {
    if (selectedValue != null) {
      context.read<HomeCubit>().editCourse(
        courseId: widget.args.id!,
        workStatus: selectedValue!,
      );

      setState(() {
        originalValue = selectedValue;
        hasChanged = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40.h,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: secondPrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.asset(
                "assets/images/online-surveys_18091734.png",
                width: 24.w,
                height: 24.h,
              ),
              SizedBox(width: 4.w),
              Text(
                AppLocalizations.of(context)!.workStatus,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: "work",
                    groupValue: selectedValue,
                    onChanged: _onStatusChanged,
                  ),
                  Text(
                    AppLocalizations.of(context)!.work,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: "not_work",
                    groupValue: selectedValue,
                    onChanged: _onStatusChanged,
                  ),
                  Text(
                    AppLocalizations.of(context)!.unWork,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
              if (hasChanged)
                InkWell(
                  onTap: _saveStatus,
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 24,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
