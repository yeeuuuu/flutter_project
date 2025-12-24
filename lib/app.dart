import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project2/styles/theme.dart';
import 'package:flutter_project2/types/index.dart';

import 'package:flutter_project2/components/home_tab.dart';
import 'package:flutter_project2/components/calendar_tab.dart';
import 'package:flutter_project2/components/notifications_tab.dart';
import 'package:flutter_project2/components/records_tab.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task & Routine App',
      theme: AppTheme.lightTheme,
      home: const MainLayout(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  List<Task> _tasks = [];
  List<RoutineStreak> _streaks = [];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    final now = DateTime.now();
    final today = DateFormat('yyyy-MM-dd').format(now);
    final yesterday =
        DateFormat('yyyy-MM-dd').format(now.subtract(const Duration(days: 1)));
    final tomorrow =
        DateFormat('yyyy-MM-dd').format(now.add(const Duration(days: 1)));
    final fourdaysago =
        DateFormat('yyyy-MM-dd').format(now.subtract(const Duration(days: 4)));

    setState(() {
      _tasks = [
        //알림 탭 표시용
        Task(
          id: 'noti_1',
          title: '아침 운동하기',
          type: 'routine',
          completed: false,
          date: today,
          color: '#10B981', // Green
          createdAt: now.toIso8601String(),
        ),
        Task(
          id: 'noti_2',
          title: '프로젝트 리뷰',
          type: 'todo',
          completed: false,
          date: yesterday,
          color: '#3B82F6', // Blue
          createdAt: now.toIso8601String(),
        ),
        Task(
          id: 'noti_3',
          title: '독서 30분',
          type: 'routine',
          completed: false,
          date: today,
          color: '#8B5CF6', // Violet
          createdAt: now.toIso8601String(),
        ),
        Task(
          id: 'done_1',
          title: '영양제 먹기',
          type: 'routine',
          completed: true,
          date: today,
          color: '#F59E0B',
          createdAt: now.toIso8601String(),
        ),
        Task(
          id: 'noti_4',
          title: '독서 동아리 회의',
          type: 'todo',
          completed: false,
          date: tomorrow,
          color: '#F59E0B',
          createdAt: now.toIso8601String(),
        ),
        Task(
          id: 'noti_5',
          title: '도서관 책 반납',
          type: 'todo',
          completed: true,
          date: fourdaysago,
          color: '#F59E0B',
          createdAt: now.toIso8601String(),
        ),
      ];

      //기록 탭 표시용
      _streaks = [
        RoutineStreak(
          routineId: 'noti_1',
          currentStreak: 5,
          longestStreak: 12,
          lastCompletedDate: today,
        ),
        RoutineStreak(
          routineId: 'noti_3',
          currentStreak: 3,
          longestStreak: 7,
          lastCompletedDate: today,
        ),
      ];
    });
  }

  void _handleUpdateTask(Task task) {
    setState(() {
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
      } else {
        _tasks.add(task);
      }
    });
  }

  void _handleDeleteTask(String id) {
    setState(() {
      _tasks.removeWhere((t) => t.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeTab(
          tasks: _tasks,
          onUpdateTask: _handleUpdateTask,
          onDeleteTask: _handleDeleteTask),
      CalendarTab(tasks: _tasks),
      NotificationTab(tasks: _tasks),
      RecordsTab(tasks: _tasks, streaks: _streaks),
    ];

    // 알림 배지 카운트
    final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final incompleteCount = _tasks
        .where((t) => !t.completed && t.date.compareTo(todayStr) <= 0)
        .length;

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: screens,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppTheme.border)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppTheme.background,
          selectedItemColor: AppTheme.primary,
          unselectedItemColor: AppTheme.mutedForeground,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(LucideIcons.home), label: '홈'),
            const BottomNavigationBarItem(
                icon: Icon(LucideIcons.calendar), label: '캘린더'),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(LucideIcons.bell),
                  if (incompleteCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                            color: AppTheme.destructive,
                            shape: BoxShape.circle),
                      ),
                    ),
                ],
              ),
              label: '알림',
            ),
            const BottomNavigationBarItem(
                icon: Icon(LucideIcons.barChart2), label: '기록'),
          ],
        ),
      ),
    );
  }
}
