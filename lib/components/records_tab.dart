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
    final progress = todayTasks.isNotEmpty ? completedToday / todayTasks.length : 0.0;

    // 모든 루틴 태스크 (현재 존재하는 루틴 목록 확인용)
    final routineTasks = tasks.where((t) => t.type == 'routine').toList();
    final uniqueRoutines = routineTasks.map((e) => e.title).toSet().toList();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. 오늘의 달성률 카드
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
                      Icon(LucideIcons.checkCircle2, size: 20, color: AppTheme.primary),
                      SizedBox(width: 8),
                      Text("오늘의 달성률", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text("${(progress * 100).toInt()}%", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppTheme.muted,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primary),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          const Text("현재 유지 중인 루틴", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          // 2. 루틴 스트릭 리스트
          if (streaks.isEmpty)
             const Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: Text("등록된 루틴 기록이 없습니다", style: TextStyle(color: AppTheme.mutedForeground))),
            )
          else
            ...streaks.map((streak) {
              // 중요: routineId와 일치하는 태스크를 안전하게 찾기
              // orElse 대신 catchError 방식을 쓰거나 collection 패키지의 firstWhereOrNull을 쓰면 좋지만,
              // 여기서는 기본 Dart로 안전하게 처리
              Task? routine;
              try {
                routine = routineTasks.firstWhere((t) => t.id == streak.routineId);
              } catch (e) {
                // 매칭되는 루틴 태스크가 없으면(삭제됨 등) 표시하지 않음
                return const SizedBox.shrink();
              }

              final color = Color(int.parse(routine.color.replaceFirst('#', '0xFF')));

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(routine.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                          Text("현재 ${streak.currentStreak}일 연속", style: const TextStyle(fontSize: 12, color: AppTheme.mutedForeground)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.muted,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text("최고 ${streak.longestStreak}일", style: const TextStyle(fontSize: 10)),
                    )
                  ],
                ),
              );
            }),

          const SizedBox(height: 24),
          
          // 3. 통계 요약 카드
          Row(
            children: [
              Expanded(
                child: _buildStatCard("전체 할 일", tasks.where((t) => t.type == 'todo').length.toString()),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard("전체 루틴", uniqueRoutines.length.toString()),
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
          Text(label, style: const TextStyle(color: AppTheme.mutedForeground, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}