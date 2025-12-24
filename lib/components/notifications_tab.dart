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

    // 미완료 태스크 필터링 (오늘 포함 이전 날짜들)
    final incompleteTasks = tasks
        .where((t) => !t.completed && t.date.compareTo(todayStr) <= 0)
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    // 날짜별 그룹화
    final Map<String, List<Task>> groupedTasks = {};
    for (var task in incompleteTasks) {
      if (!groupedTasks.containsKey(task.date)) {
        groupedTasks[task.date] = [];
      }
      groupedTasks[task.date]!.add(task);
    }

    return Scaffold(
      backgroundColor: AppTheme.background, // 배경색 확인
      body: Column(
        children: [
          // 상단 헤더
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              children: const [
                Icon(LucideIcons.bell, size: 24),
                SizedBox(width: 8),
                Text("미완료 알림",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          Expanded(
            child: incompleteTasks.isEmpty
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
                          child: const Icon(LucideIcons.checkCircle2,
                              size: 32, color: AppTheme.mutedForeground),
                        ),
                        const SizedBox(height: 16),
                        const Text("모든 작업을 완료했어요!",
                            style: TextStyle(color: AppTheme.mutedForeground)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: groupedTasks.keys.length,
                    itemBuilder: (context, index) {
                      final dateKey = groupedTasks.keys.elementAt(index);
                      final tasksForDay = groupedTasks[dateKey]!;

                      // 날짜 표시 텍스트 (오늘인 경우 특별 처리)
                      String dateLabel = dateKey;
                      bool isToday = dateKey == todayStr;
                      if (isToday) dateLabel = "오늘";

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 날짜 헤더
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 8),
                            child: Row(
                              children: [
                                Icon(LucideIcons.alertCircle,
                                    size: 16,
                                    color: isToday
                                        ? Colors.orange
                                        : AppTheme.mutedForeground),
                                const SizedBox(width: 6),
                                Text(
                                  dateLabel,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: isToday
                                          ? AppTheme.foreground
                                          : AppTheme.mutedForeground),
                                ),
                              ],
                            ),
                          ),
                          // 해당 날짜의 태스크 리스트
                          ...tasksForDay.map((task) {
                            final color = Color(int.parse(
                                task.color.replaceFirst('#', '0xFF')));
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppTheme.border),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.02),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    )
                                  ]),
                              child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    // 좌측 컬러 바
                                    Container(
                                      width: 6,
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                        ),
                                      ),
                                    ),
                                    // 내용 영역
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                // 점 아이콘
                                                Container(
                                                  width: 8,
                                                  height: 8,
                                                  decoration: BoxDecoration(
                                                    color: color,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(task.title,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            // 태그 (루틴 / 할 일)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: color
                                                          .withOpacity(0.5)),
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              child: Text(
                                                task.type == 'routine'
                                                    ? '루틴'
                                                    : '할 일',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: color,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
