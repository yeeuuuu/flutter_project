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
    final yesterday = DateFormat('yyyy-MM-dd').format(now.subtract(const Duration(days: 1)));
    final tomorrow = DateFormat('yyyy-MM-dd').format(now.add(const Duration(days: 1)));

    setState(() {
      _tasks = [
        // 1. [알림 탭용] 어제 못 끝낸 할 일 (이게 있어야 알림에 뜸)
        Task(
          id: 'missed_1',
          title: '어제 못 한 영어 공부',
          type: 'todo',
          completed: false,
          date: yesterday,
          color: '#EF4444', // Red
          createdAt: now.subtract(const Duration(days: 1)).toIso8601String(),
        ),
        // 2. [기록 탭용] 루틴 1 (아침 운동)
        Task(
          id: 'routine_1',
          title: '아침 운동하기',
          type: 'routine',
          completed: true, // 오늘은 완료함
          date: today,
          color: '#10B981', // Green
          createdAt: now.toIso8601String(),
        ),
        // 3. [홈 탭용] 오늘의 할 일
        Task(
          id: 'todo_1',
          title: '장보기',
          type: 'todo',
          completed: false,
          date: today,
          color: '#F59E0B', // Amber
          createdAt: now.toIso8601String(),
        ),
        // 4. [기록 탭용] 루틴 2 (독서)
        Task(
          id: 'routine_2',
          title: '잠들기 전 독서',
          type: 'routine',
          completed: false,
          date: today,
          color: '#8B5CF6', // Violet
          createdAt: now.toIso8601String(),
        ),
        // 5. 내일 할 일
        Task(
          id: 'todo_future',
          title: '주간 회의 준비',
          type: 'todo',
          completed: false,
          date: tomorrow,
          color: '#3B82F6', // Blue
          createdAt: now.toIso8601String(),
        ),
      ];

      // [기록 탭용] 루틴 연속 기록 데이터 (ID를 위 Task와 일치시킴)
      _streaks = [
        RoutineStreak(
          routineId: 'routine_1', // 아침 운동하기와 매칭
          currentStreak: 5,
          longestStreak: 12,
          lastCompletedDate: today,
        ),
        RoutineStreak(
          routineId: 'routine_2', // 독서와 매칭
          currentStreak: 2,
          longestStreak: 4,
          lastCompletedDate: yesterday,
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
      HomeTab(tasks: _tasks, onUpdateTask: _handleUpdateTask, onDeleteTask: _handleDeleteTask),
      CalendarTab(tasks: _tasks),
      NotificationTab(tasks: _tasks), // 이제 어제 미완료 태스크가 보일 것입니다.
      RecordsTab(tasks: _tasks, streaks: _streaks), // 이제 루틴 기록이 보일 것입니다.
    ];

    // 알림 배지 카운트 (오늘 이전 미완료 태스크)
    final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final incompleteCount = _tasks.where((t) => !t.completed && t.date.compareTo(todayStr) <= 0).length;

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
            const BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: '홈'),
            const BottomNavigationBarItem(icon: Icon(LucideIcons.calendar), label: '캘린더'),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(LucideIcons.bell),
                  if (incompleteCount > 0)
                    Positioned(
                      right: 0, top: 0,
                      child: Container(
                        width: 8, height: 8,
                        decoration: const BoxDecoration(color: AppTheme.destructive, shape: BoxShape.circle),
                      ),
                    ),
                ],
              ),
              label: '알림',
            ),
            const BottomNavigationBarItem(icon: Icon(LucideIcons.barChart2), label: '기록'),
          ],
        ),
      ),
    );
  }
}