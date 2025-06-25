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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
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
                Image.asset(widget.iconPath, width: 24.w, height: 24.h),
                SizedBox(width: 4.w),
                Text(
                  widget.label,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  style: TextStyle(fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: widget.initialValue,
                    hintStyle: TextStyle(fontSize: 14.sp),
                    border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: secondPrimary,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: secondPrimary,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: secondPrimary)),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                if (_hasChanged)
                  Positioned(
                    right: 8,
                    child: InkWell(
                      onTap: _saveManually,
                      child: Icon(Icons.check, color: Colors.green, size: 28.sp),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

