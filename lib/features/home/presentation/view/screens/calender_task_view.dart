import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:courses_app/features/home/data/models/get_tasks_model.dart';
import 'package:courses_app/features/home/presentation/view/screens/task_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/calender_task_card.dart';

class TaskCalendarView extends StatefulWidget {
  final List<TaskResult> tasks;

  const TaskCalendarView({super.key, required this.tasks});

  @override
  State<TaskCalendarView> createState() => _TaskCalendarViewState();
}

class _TaskCalendarViewState extends State<TaskCalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  DateTime? tryParseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    try {
      return DateTime.parse(dateStr);
    } catch (_) {
      return null;
    }
  }

  List<TaskResult> _getTasksForDay(DateTime day) {
    return widget.tasks.where((task) {
      final taskDate = tryParseDate(task.deadline);
      return taskDate != null && isSameDay(taskDate, day);
    }).toList();
  }

  Map<DateTime, List<TaskResult>> _getEventsMap() {
    Map<DateTime, List<TaskResult>> events = {};
    for (var task in widget.tasks) {
      final date = tryParseDate(task.deadline);
      if (date != null) {
        final eventDate = DateTime(date.year, date.month, date.day);
        events.putIfAbsent(eventDate, () => []).add(task);
      }
    }
    return events;
  }

  @override
  Widget build(BuildContext context) {
    final tasksForSelectedDay =
    _selectedDay != null ? _getTasksForDay(_selectedDay!) : [];
    final eventsMap = _getEventsMap();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar<TaskResult>(
              firstDay: DateTime.utc(2000),
              lastDay: DateTime.utc(2100),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              eventLoader: (day) {
                final key = DateTime(day.year, day.month, day.day);
                return eventsMap[key] ?? [];
              },
              calendarStyle: CalendarStyle(
                markerDecoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                weekendStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  fontSize: 16.sp,
                ),
              ),
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Tasks for ${DateFormat('MMM d, yyyy').format(_selectedDay ?? _focusedDay)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 12.h),
            tasksForSelectedDay.isEmpty
                ? Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: Center(
                child: Text(
                  "No tasks on selected day.",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            )
                : ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tasksForSelectedDay.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final task = tasksForSelectedDay[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      TaskDetailsScreen.routeName,
                      arguments: task,
                    );
                  },
                  child: CalendarTaskCard(task: task),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
