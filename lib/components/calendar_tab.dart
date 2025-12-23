import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  @override
  Widget build(BuildContext context) {
    final selectedDateStr = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final tasksForDate =
        widget.tasks.where((t) => t.date == selectedDateStr).toList();

    return Column(
      children: [
        // Calendar View
        Container(
          color: AppTheme.background,
          child: CalendarDatePicker(
            initialDate: _selectedDate,
            firstDate: DateTime(2020),
            lastDate: DateTime(2030),
            onDateChanged: (date) => setState(() => _selectedDate = date),
          ),
        ),

        const Divider(height: 1),

        // Tasks List
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                "${_selectedDate.month}월 ${_selectedDate.day}일 일정",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              if (tasksForDate.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text("이 날짜에 일정이 없습니다",
                        style: TextStyle(color: AppTheme.mutedForeground)),
                  ),
                )
              else
                ...tasksForDate.map((task) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.background,
                        border: Border.all(color: AppTheme.border),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                                color: Color(int.parse(
                                    task.color.replaceFirst('#', '0xFF'))),
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.title,
                                  style: TextStyle(
                                    decoration: task.completed
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: task.completed
                                        ? AppTheme.mutedForeground
                                        : AppTheme.foreground,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppTheme.border),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Text(
                                    task.type == 'routine' ? '루틴' : '할 일',
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: AppTheme.mutedForeground),
                                  ),
                                )
                              ],
                            ),
                          ),
                          if (task.completed)
                            const Text("완료",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.mutedForeground)),
                        ],
                      ),
                    ))
            ],
          ),
        ),
      ],
    );
  }
}
