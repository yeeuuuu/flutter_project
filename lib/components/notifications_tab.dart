import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project2/types/index.dart';
import 'package:flutter_project2/styles/theme.dart';

class NotificationTab extends StatelessWidget {
  final List<Task> tasks;

  const NotificationTab({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Filter incomplete tasks <= today
    final incompleteTasks = tasks
        .where((t) => !t.completed && t.date.compareTo(todayStr) <= 0)
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    // Group by date
    final Map<String, List<Task>> groupedTasks = {};
    for (var task in incompleteTasks) {
      if (!groupedTasks.containsKey(task.date)) {
        groupedTasks[task.date] = [];
      }
      groupedTasks[task.date]!.add(task);
    }

    return Scaffold(
      body: incompleteTasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppTheme.muted,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(LucideIcons.bell,
                        size: 32, color: AppTheme.mutedForeground),
                  ),
                  const SizedBox(height: 16),
                  const Text("미완료된 일정이 없습니다",
                      style: TextStyle(color: AppTheme.mutedForeground)),
                  const Text("모든 작업을 완료했어요!",
                      style: TextStyle(
                          fontSize: 12, color: AppTheme.mutedForeground)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: groupedTasks.keys.length,
              itemBuilder: (context, index) {
                final dateKey = groupedTasks.keys.elementAt(index);
                final tasksForDay = groupedTasks[dateKey]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        dateKey, // 실제로는 날짜 포맷팅 함수 필요 (예: 10월 5일)
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.mutedForeground),
                      ),
                    ),
                    ...tasksForDay.map((task) {
                      final color = Color(
                          int.parse(task.color.replaceFirst('#', '0xFF')));
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                          borderRadius: BorderRadius.circular(8),
                          border: Border(
                            left: BorderSide(color: color, width: 4),
                            top: const BorderSide(color: AppTheme.border),
                            right: const BorderSide(color: AppTheme.border),
                            bottom: const BorderSide(color: AppTheme.border),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                    color: color, shape: BoxShape.circle)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(task.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 1),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: color),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Text(
                                      task.type == 'routine' ? '루틴' : '할 일',
                                      style:
                                          TextStyle(fontSize: 10, color: color),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
    );
  }
}
