import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/styles/colors.dart'; // Make sure to import this

class EditableDateField extends StatefulWidget{
  final String label;
  final String iconPath;
  final String initialValue;
  final TextEditingController controller;
  final void Function(String) onSave;

  const EditableDateField({
    super.key,
    required this.label,
    required this.iconPath,
    required this.initialValue,
    required this.controller,
    required this.onSave,
  });

  @override
  State<EditableDateField> createState() => _EditableDateFieldState();
}

class _EditableDateFieldState extends State<EditableDateField> {
  late String _initialValue;
  bool _hasChanged = false;

  @override
  void initState() {
    super.initState();
    _initialValue = widget.initialValue;
    widget.controller.text = widget.initialValue;
  }

  Future<void> _selectDate() async {
    DateTime initialDate = DateTime.tryParse(_initialValue.split('T').first) ?? DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final formatted = DateFormat('yyyy-MM-dd').format(pickedDate);
      if (formatted != _initialValue) {
        widget.controller.text = formatted;
        setState(() {
          _initialValue = formatted;
          _hasChanged = false;
        });
        widget.onSave(formatted);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: secondPrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.asset(widget.iconPath, width: 24.w, height: 24.h),
              SizedBox(width: 6.w),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: InkWell(
            onTap: _selectDate,
            child: IgnorePointer(
              child: TextFormField(
                controller: widget.controller,
                readOnly: true,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: "yyyy-MM-dd",
                  hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: secondPrimary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: secondPrimary),
                  ),
                  suffixIcon: Icon(Icons.calendar_today, size: 20.sp, color: primaryColor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
