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

    // 미완료 태스크 필터링
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
      backgroundColor: Colors.white, // 배경색 흰색 유지
      body: Column(
        children: [
          // 상단 헤더
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              children: const [
                Icon(LucideIcons.bell, size: 24, color: Colors.black87),
                SizedBox(width: 8),
                Text("미완료 알림",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
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
                      color: Color(0xFFF3F4F6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(LucideIcons.checkCircle2,
                        size: 32, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  const Text("모든 작업을 완료했어요!",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: groupedTasks.keys.length,
              itemBuilder: (context, index) {
                final dateKey = groupedTasks.keys.elementAt(index);
                final tasksForDay = groupedTasks[dateKey]!;

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
                              color: isToday ? Colors.orange : Colors.grey),
                          const SizedBox(width: 6),
                          Text(
                            dateLabel,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isToday
                                    ? Colors.black87
                                    : Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    // 리스트 아이템
                    ...tasksForDay.map((task) {
                      final color = Color(int.parse(
                          task.color.replaceFirst('#', '0xFF')));

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        width: double.infinity,
                        // [핵심 수정] IntrinsicHeight 대신 Border 사용으로 충돌 원천 차단
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border(
                            // 왼쪽만 굵은 컬러 테두리 (디자인 유지)
                            left: BorderSide(color: color, width: 6),
                            // 나머지는 얇은 회색 테두리
                            top: BorderSide(color: Colors.grey.shade200),
                            right: BorderSide(color: Colors.grey.shade200),
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // 제목 옆 점 아이콘
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // 제목 텍스트 (검정색 강제)
                                  Expanded(
                                    child: Text(task.title,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // 태그 (루틴 / 할 일)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: color.withOpacity(0.5)),
                                    borderRadius:
                                    BorderRadius.circular(6)),
                                child: Text(
                                  task.type == 'routine' ? '루틴' : '할 일',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: color,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
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