import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project2/types/index.dart';
import 'package:flutter_project2/styles/theme.dart';

class RecordsTab extends StatelessWidget {
  final List<Task> tasks;
  final List<RoutineStreak> streaks;

  const RecordsTab({super.key, required this.tasks, required this.streaks});

  @override
  Widget build(BuildContext context) {
    final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final todayTasks = tasks.where((t) => t.date == todayStr).toList();
    final completedToday = todayTasks.where((t) => t.completed).length;
    final progress =
        todayTasks.isNotEmpty ? completedToday / todayTasks.length : 0.0;

    final routineTasks = tasks.where((t) => t.type == 'routine').toList();
    // Unique routines logic simplified for UI demo
    final uniqueRoutines = routineTasks.map((e) => e.title).toSet().toList();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Today Progress
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: AppTheme.border),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(LucideIcons.checkCircle2,
                          size: 20, color: AppTheme.primary),
                      SizedBox(width: 8),
                      Text("오늘의 달성률",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text("${(progress * 100).toInt()}%",
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppTheme.muted,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(AppTheme.primary),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          const Text("루틴 현황",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          // Streaks List (Mock UI based on React logic)
          if (streaks.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(
                  child: Text("등록된 루틴이 없습니다",
                      style: TextStyle(color: AppTheme.mutedForeground))),
            )
          else
            ...streaks.map((streak) {
              // Find matching routine info (simplified lookup)
              final routine = routineTasks.firstWhere(
                  (t) => t.id == streak.routineId,
                  orElse: () => routineTasks[0]);
              final color =
                  Color(int.parse(routine.color.replaceFirst('#', '0xFF')));

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.border),
                  borderRadius: BorderRadius.circular(8),
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
                          Text(routine.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                          Text("현재 ${streak.currentStreak}일 연속",
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.mutedForeground)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.muted,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text("최고 ${streak.longestStreak}일",
                          style: const TextStyle(fontSize: 10)),
                    )
                  ],
                ),
              );
            }),

          const SizedBox(height: 24),

          // Simple Stats Grid
          Row(
            children: [
              Expanded(
                child: _buildStatCard("전체 할 일",
                    tasks.where((t) => t.type == 'todo').length.toString()),
              ),
              const SizedBox(width: 12),
              Expanded(
                child:
                    _buildStatCard("전체 루틴", uniqueRoutines.length.toString()),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(label,
              style: const TextStyle(
                  color: AppTheme.mutedForeground, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
