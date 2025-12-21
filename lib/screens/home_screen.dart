import 'package:flutter/material.dart';
import '../models/types.dart';
import '../theme/app_theme.dart';
import '../widgets/feature/task_item.dart';
import '../widgets/feature/task_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 임시 데이터 (나중에 DB나 API로 교체)
  List<Task> tasks = [
    Task(
      id: '1',
      title: '아침 운동하기',
      completed: false,
      date: DateTime.now(),
      category: Category.personal,
      priority: Priority.high,
    ),
    Task(
      id: '2',
      title: 'Flutter 프로젝트 구조 잡기',
      completed: true,
      date: DateTime.now(),
      category: Category.work,
      priority: Priority.medium,
    ),
    Task(
      id: '3',
      title: '내일 회의 준비',
      completed: false,
      date: DateTime.now().add(const Duration(days: 1)),
      category: Category.work,
      priority: Priority.high,
    ),
  ];

  // 날짜 비교 헬퍼 함수
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // 다이얼로그 열기
  void _openTaskDialog({Task? task}) {
    showDialog(
      context: context,
      builder: (context) => TaskDialog(
        editingTask: task,
        onSave: (newTask) {
          setState(() {
            if (task == null) {
              // 추가
              tasks.add(newTask);
            } else {
              // 수정
              final index = tasks.indexWhere((t) => t.id == task.id);
              if (index != -1) {
                tasks[index] = newTask;
              }
            }
          });
        },
      ),
    );
  }

  // 삭제 로직
  // (React의 handleDeleteTask)
  // 실제 구현시 TaskItem에 삭제 버튼을 추가하거나 스와이프로 구현

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));

    final todayTasks = tasks.where((t) => isSameDay(t.date, now)).toList();
    final tomorrowTasks = tasks
        .where((t) => isSameDay(t.date, tomorrow))
        .toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTaskDialog(),
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 헤더 영역
            const Text(
              "좋은 오후입니다, 사용자님!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "오늘의 계획을 확인해보세요.",
              style: TextStyle(color: AppTheme.mutedForeground),
            ),
            const SizedBox(height: 32),

            // 오늘 섹션
            _buildSectionHeader("오늘", Colors.black),
            if (todayTasks.isEmpty)
              _buildEmptyState("오늘 할 일이 없습니다.")
            else
              ...todayTasks.map(
                (task) => GestureDetector(
                  onTap: () => _openTaskDialog(task: task), // 탭하면 수정
                  child: TaskItem(
                    task: task,
                    onToggle: (val) {
                      setState(() {
                        // copyWith를 사용해 불변성 유지하며 업데이트
                        final index = tasks.indexOf(task);
                        tasks[index] = task.copyWith(completed: val);
                      });
                    },
                  ),
                ),
              ),

            const SizedBox(height: 32),

            // 내일 섹션
            _buildSectionHeader("내일", AppTheme.mutedForeground),
            if (tomorrowTasks.isEmpty)
              _buildEmptyState("내일 예정된 일이 없습니다.")
            else
              ...tomorrowTasks.map(
                (task) => TaskItem(
                  task: task,
                  onToggle: (val) {
                    setState(() {
                      final index = tasks.indexOf(task);
                      tasks[index] = task.copyWith(completed: val);
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color dotColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.border, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(AppTheme.radius),
        color: AppTheme.background, // or muted/50
      ),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(color: AppTheme.mutedForeground),
        ),
      ),
    );
  }
}
