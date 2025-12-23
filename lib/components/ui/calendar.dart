import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const AppCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12), // p-3
      decoration: BoxDecoration(
        color: AppTheme.background,
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Theme(
        // 캘린더 내부 스타일 커스터마이징
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppTheme.primary, // 선택된 날짜 배경
            onPrimary: AppTheme.primaryForeground, // 선택된 날짜 텍스트
            onSurface: AppTheme.foreground, // 달력 텍스트
          ),
        ),
        child: CalendarDatePicker(
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          onDateChanged: onDateChanged,
        ),
      ),
    );
  }
}
