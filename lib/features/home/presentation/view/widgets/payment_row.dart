import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:courses_app/features/home/data/models/get_courses_model.dart';
import 'package:courses_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:courses_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentRow extends StatefulWidget{
  final CoursesResult args;

  const PaymentRow({Key? key, required this.args}) : super(key: key);

  @override
  State<PaymentRow> createState() => _PaymentRowState();
}

class _PaymentRowState extends State<PaymentRow> {
  late String? selectedValue;
  late String? originalValue;
  bool hasChanged = false;

  @override
  void initState() {
    super.initState();
    originalValue = widget.args.payMethod?.toLowerCase(); // Correct initial value
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
        payment: selectedValue!,
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
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Image.asset(
                "assets/images/money_14858977.png",
                width: 24.w,
                height: 24.h,
              ),
              SizedBox(width: 4.w),
              Text(
                AppLocalizations.of(context)!.paymentMethod,
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
                    value: "cash",
                    groupValue: selectedValue,
                    onChanged: _onStatusChanged,
                  ),
                  Text(
                    AppLocalizations.of(context)!.cash,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: "online",
                    groupValue: selectedValue,
                    onChanged: _onStatusChanged,
                  ),
                  Text(
                    AppLocalizations.of(context)!.online,
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