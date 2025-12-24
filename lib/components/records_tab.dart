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
    final int percentage = (progress * 100).toInt();

    final routineTasks = tasks.where((t) => t.type == 'routine').toList();
    final uniqueRoutines = routineTasks.map((e) => e.title).toSet().toList();

    // 최장 스트릭 찾기 로직
    RoutineStreak? longestStreakRecord;
    Task? longestStreakTask;
    if (streaks.isNotEmpty) {
      // 기록 중 가장 긴 것 찾기
      final sortedStreaks = List<RoutineStreak>.from(streaks)
        ..sort((a, b) => b.longestStreak.compareTo(a.longestStreak));

      if (sortedStreaks.isNotEmpty) {
        longestStreakRecord = sortedStreaks.first;
        try {
          longestStreakTask =
              tasks.firstWhere((t) => t.id == longestStreakRecord!.routineId);
        } catch (_) {}
      }
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Row(
            children: [
              Icon(LucideIcons.trophy, size: 24),
              SizedBox(width: 8),
              Text("나의 기록",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppTheme.border),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(LucideIcons.checkCircle2, size: 18),
                    SizedBox(width: 8),
                    Text("오늘의 진행률",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("$completedToday / ${todayTasks.length} 완료",
                        style: const TextStyle(
                            color: AppTheme.mutedForeground, fontSize: 13)),
                    Text("$percentage%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppTheme.muted,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.black),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          if (longestStreakRecord != null && longestStreakTask != null) ...[
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppTheme.border),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(LucideIcons.trendingUp, size: 18),
                      SizedBox(width: 8),
                      Text("최장 루틴 기록",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Color(int.parse(longestStreakTask.color
                                      .replaceFirst('#', '0xFF'))),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(longestStreakTask.title,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text("연속 달성",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.mutedForeground)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text("${longestStreakRecord.longestStreak}",
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold)),
                          const Text(" 일",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.mutedForeground)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          const Text("현재 유지 중인 루틴",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          if (streaks.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(
                  child: Text("등록된 루틴 기록이 없습니다",
                      style: TextStyle(color: AppTheme.mutedForeground))),
            )
          else
            ...streaks.map((streak) {
              Task? routine;
              try {
                routine = tasks.firstWhere((t) => t.id == streak.routineId);
              } catch (_) {
                return const SizedBox.shrink();
              }

              final color =
                  Color(int.parse(routine.color.replaceFirst('#', '0xFF')));

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppTheme.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            color: color, shape: BoxShape.circle)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(routine.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                          const SizedBox(height: 4),
                          Text("현재 ${streak.currentStreak}일 연속",
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.mutedForeground)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.muted,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text("최고 ${streak.longestStreak}일",
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
              );
            }),

          const SizedBox(height: 12),
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
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(label,
              style: const TextStyle(
                  color: AppTheme.mutedForeground, fontSize: 12)),
          const SizedBox(height: 8),
          Text(value,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
