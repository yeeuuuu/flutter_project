import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project2/styles/theme.dart';
import 'package:flutter_project2/types/index.dart';

// 컴포넌트 Import
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

    // 알림 테스트를 위해 '오늘'이지만 아직 완료 안 된 태스크들을 생성합니다.
    setState(() {
      _tasks = [
        // [알림 탭 표시용] 1. 아침 운동하기 (루틴, 미완료)
        Task(
          id: 'noti_1',
          title: '아침 운동하기',
          type: 'routine',
          completed: false,
          date: today,
          color: '#10B981', // Green
          createdAt: now.toIso8601String(),
        ),
        // [알림 탭 표시용] 2. 프로젝트 리뷰 (할 일, 미완료)
        Task(
          id: 'noti_2',
          title: '프로젝트 리뷰',
          type: 'todo',
          completed: false,
          date: today,
          color: '#3B82F6', // Blue
          createdAt: now.toIso8601String(),
        ),
        // [알림 탭 표시용] 3. 독서 30분 (루틴, 미완료)
        Task(
          id: 'noti_3',
          title: '독서 30분',
          type: 'routine',
          completed: false,
          date: today,
          color: '#8B5CF6', // Violet
          createdAt: now.toIso8601String(),
        ),
        // [기록 탭 통계용] 완료된 샘플
        Task(
          id: 'done_1',
          title: '영양제 먹기',
          type: 'routine',
          completed: true,
          date: today,
          color: '#F59E0B',
          createdAt: now.toIso8601String(),
        ),
      ];

      // [기록 탭 표시용] 루틴 연속 기록 데이터
      _streaks = [
        RoutineStreak(
          routineId: 'noti_1', // 아침 운동하기
          currentStreak: 5,
          longestStreak: 12, // 최장 기록 12일
          lastCompletedDate: today,
        ),
        RoutineStreak(
          routineId: 'noti_3', // 독서 30분
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

    // 알림 배지 카운트 (오늘 포함 이전 미완료 태스크)
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
