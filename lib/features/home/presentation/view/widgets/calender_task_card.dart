import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:courses_app/features/home/data/models/get_tasks_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalendarTaskCard extends StatelessWidget {
  final TaskResult task;

  const CalendarTaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(
        bottom: 8
      ),
      decoration: BoxDecoration(
        color:Colors.grey[200],
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: secondPrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.task_alt_rounded, color: primaryColor, size: 22.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  task.name ?? "No Title",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          /// Description
          if ((task.description ?? '').isNotEmpty)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.description_outlined,
                    color: Colors.black, size: 18.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    _stripHtml(task.description ?? ""),
                    style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

          SizedBox(height: 10.h),

          /// Deadline
          Row(
            children: [
              Icon(Icons.calendar_today_outlined,
                  color: Colors.black, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                _formatDate(task.deadline),
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateStr) {
    try {
      final date = DateTime.parse(dateStr ?? "");
      return "${date.day}/${date.month}/${date.year}";
    } catch (_) {
      return "No date";
    }
  }

  String _stripHtml(String htmlText) {
    final exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }
}
