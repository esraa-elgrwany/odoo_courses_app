import 'dart:async';
import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditableField extends StatefulWidget {
  final String label;
  final String iconPath;
  final String initialValue;
  final TextEditingController controller;
  final void Function(String) onSave;
  final TextInputType? keyboardType;

  const EditableField({
    super.key,
    required this.label,
    required this.iconPath,
    required this.initialValue,
    required this.controller,
    required this.onSave,
    this.keyboardType,
  });

  @override
  State<EditableField> createState() => _EditableFieldState();
}

class _EditableFieldState extends State<EditableField> {
  late String _initialValue;
  Timer? _debounce;
  bool _hasChanged = false;

  @override
  void initState() {
    super.initState();
    _initialValue = widget.initialValue;
    widget.controller.text = widget.initialValue;
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      final currentValue = widget.controller.text;
      setState(() {
        _hasChanged = currentValue != _initialValue;
      });
    });
  }

  void _saveManually() {
    final currentValue = widget.controller.text;
    if (currentValue != _initialValue) {
      setState(() {
        _initialValue = currentValue;
        _hasChanged = false;
      });
      widget.onSave(currentValue);
      FocusScope.of(context).unfocus(); // Hide keyboard after save
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical:8.h),
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
                  color:Colors.black,
                ),
              ),
            ],
          ),
        ),
         SizedBox(width:8.w),
        Expanded(
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: widget.initialValue,
              hintStyle: TextStyle(fontSize: 12.sp, color: Colors.black,fontWeight: FontWeight.w500),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical:4),
              isDense: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: secondPrimary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color:secondPrimary),
              ),
              suffixIcon: _hasChanged
                  ? Tooltip(
                message: "Save",
                child: InkWell(
                  onTap: _saveManually,
                  child: Icon(Icons.check, color: Colors.green, size: 24.sp),
                ),
              )
                  : Icon(Icons.edit, color:primaryColor, size: 20.sp),
            ),
            maxLines: null,
            minLines: 1,
            onFieldSubmitted: (value) {
              if (value != _initialValue) {
                _initialValue = value;
                _hasChanged = false;
                widget.onSave(value);
              }
            },
          ),
        ),
      ],
    );
  }
}


