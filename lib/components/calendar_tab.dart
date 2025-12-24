import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_project2/types/index.dart';
import 'package:flutter_project2/styles/theme.dart';

class CalendarTab extends StatefulWidget {
  final List<Task> tasks;

  const CalendarTab({super.key, required this.tasks});

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildDaysOfWeek(),
        _buildCalendarGrid(),
        const Divider(height: 1, color: AppTheme.border),
        Expanded(
          child: _buildTaskList(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(LucideIcons.chevronLeft),
            onPressed: () {
              setState(() {
                _focusedDate =
                    DateTime(_focusedDate.year, _focusedDate.month - 1);
              });
            },
          ),
          Text(
            DateFormat('yyyy년 MM월').format(_focusedDate),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(LucideIcons.chevronRight),
            onPressed: () {
              setState(() {
                _focusedDate =
                    DateTime(_focusedDate.year, _focusedDate.month + 1);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDaysOfWeek() {
    final days = ['일', '월', '화', '수', '목', '금', '토'];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days
            .map((day) => Text(
                  day,
                  style: const TextStyle(
                    color: AppTheme.mutedForeground,
                    fontWeight: FontWeight.w500,
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth =
        DateTime(_focusedDate.year, _focusedDate.month + 1, 0).day;
    final firstDayOfMonth = DateTime(_focusedDate.year, _focusedDate.month, 1);

    final weekdayOffset = firstDayOfMonth.weekday % 7;

    return GridView.builder(
      shrinkWrap: true, 
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, 
        childAspectRatio: 1.2,
      ),
      itemCount: daysInMonth + weekdayOffset,
      itemBuilder: (context, index) {
        if (index < weekdayOffset) {
          return const SizedBox.shrink(); 
        }

        final day = index - weekdayOffset + 1;
        final currentDate =
            DateTime(_focusedDate.year, _focusedDate.month, day);
        final currentDateStr = DateFormat('yyyy-MM-dd').format(currentDate);
        final hasTasks = widget.tasks.any((t) => t.date == currentDateStr);
        final hasIncomplete =
            widget.tasks.any((t) => t.date == currentDateStr && !t.completed);

        final isSelected = isSameDay(currentDate, _selectedDate);
        final isToday = isSameDay(currentDate, DateTime.now());

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = currentDate;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primary
                      : (isToday ? AppTheme.primary.withOpacity(0.1) : null),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$day',
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : (isToday ? AppTheme.primary : Colors.black),
                    fontWeight: isSelected || isToday
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              if (hasTasks)
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: hasIncomplete ? AppTheme.destructive : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                )
              else
                const SizedBox(height: 5),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTaskList() {
    final selectedDateStr = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final tasksForDate =
        widget.tasks.where((t) => t.date == selectedDateStr).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          "${DateFormat('M월 d일').format(_selectedDate)} 일정",
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.mutedForeground),
        ),
        const SizedBox(height: 12),
        if (tasksForDate.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                "등록된 일정이 없습니다.",
                style: TextStyle(color: AppTheme.mutedForeground),
              ),
            ),
          )
        else
          ...tasksForDate.map((task) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppTheme.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(
                            int.parse(task.color.replaceFirst('#', '0xFF'))),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 14,
                              decoration: task.completed
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: task.completed
                                  ? AppTheme.mutedForeground
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            task.type == 'routine' ? '루틴' : '할 일',
                            style: const TextStyle(
                                fontSize: 10, color: AppTheme.mutedForeground),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
      ],
    );
  }
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
