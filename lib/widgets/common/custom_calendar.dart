import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../theme/app_theme.dart';

class CustomCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Function(DateTime, DateTime) onDaySelected;

  const CustomCalendar({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radius),
        border: Border.all(color: AppTheme.border),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        onDaySelected: onDaySelected,

        // 스타일 커스텀 (shadcn 느낌)
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          leftChevronIcon: Icon(Icons.chevron_left, size: 20),
          rightChevronIcon: Icon(Icons.chevron_right, size: 20),
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: const BoxDecoration(
            color: AppTheme.muted,
            shape: BoxShape.circle,
          ),
          todayTextStyle: const TextStyle(color: AppTheme.foreground),
          selectedDecoration: const BoxDecoration(
            color: AppTheme.primary,
            shape: BoxShape.circle,
          ),
          defaultTextStyle: const TextStyle(fontSize: 14),
          outsideDaysVisible: false,
        ),
      ),
    );
  }
}
