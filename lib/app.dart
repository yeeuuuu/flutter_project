import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart'; // 날짜 포맷용
import 'package:uuid/uuid.dart'; // ID 생성용

// 스타일 및 유틸
import 'package:flutter_project2/styles/theme.dart';
import 'package:flutter_project2/types/index.dart'; // Task, RoutineStreak 모델

// 탭 컴포넌트 Import
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

  // React의 useState와 동일한 상태 관리 변수들
  List<Task> _tasks = [];
  List<RoutineStreak> _streaks = [];

  @override
  void initState() {
    super.initState();
    _loadInitialData(); // 앱 시작 시 초기 데이터 로드
  }

  // 초기 샘플 데이터 로드 (React의 useEffect 로직 대응)
  void _loadInitialData() {
    final now = DateTime.now();
    final today = DateFormat('yyyy-MM-dd').format(now);
    final tomorrow = DateFormat('yyyy-MM-dd').format(now.add(const Duration(days: 1)));

    setState(() {
      _tasks = [
        Task(
          id: '1',
          title: '아침 운동하기',
          type: 'routine',
          completed: false,
          date: today,
          color: '#10B981', // Green
          createdAt: now.toIso8601String(),
        ),
        Task(
          id: '2',
          title: '프로젝트 리뷰',
          type: 'todo',
          completed: false,
          date: today,
          color: '#3B82F6', // Blue
          createdAt: now.toIso8601String(),
        ),
        Task(
          id: '3',
          title: '장보기',
          type: 'todo',
          completed: true,
          date: today,
          color: '#F59E0B', // Amber
          createdAt: now.toIso8601String(),
        ),
        Task(
          id: '4',
          title: '독서 30분',
          type: 'routine',
          completed: false,
          date: tomorrow,
          color: '#8B5CF6', // Violet
          createdAt: now.toIso8601String(),
        ),
      ];

      // 루틴 연속 달성 기록 샘플
      _streaks = [
        RoutineStreak(
          routineId: '1', // 아침 운동하기
          currentStreak: 3,
          longestStreak: 5,
          lastCompletedDate: DateFormat('yyyy-MM-dd').format(now.subtract(const Duration(days: 1))),
        ),
      ];
    });
  }

  // 할 일 추가 및 수정 핸들러
  void _handleUpdateTask(Task task) {
    setState(() {
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        // 기존 태스크 수정
        _tasks[index] = task;
      } else {
        // 새 태스크 추가
        _tasks.add(task);
      }
    });
  }

  // 할 일 삭제 핸들러
  void _handleDeleteTask(String id) {
    setState(() {
      _tasks.removeWhere((t) => t.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // React의 nav 순서: Home -> Calendar -> Notifications -> Records
    // 각 탭에 필요한 데이터를 prop으로 전달
    final List<Widget> screens = [
      HomeTab(
        tasks: _tasks,
        onUpdateTask: _handleUpdateTask,
        onDeleteTask: _handleDeleteTask,
      ),
      CalendarTab(
        tasks: _tasks,
      ),
      NotificationTab(
        tasks: _tasks,
      ),
      RecordsTab(
        tasks: _tasks,
        streaks: _streaks,
      ),
    ];

    // 읽지 않은 알림 개수 계산 (오늘 이전의 미완료 태스크)
    final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final incompleteCount = _tasks.where((t) => !t.completed && t.date.compareTo(todayStr) <= 0).length;

    return Scaffold(
      body: SafeArea(
        // IndexedStack을 사용하여 탭 전환 시 화면 상태 유지 (React Router와 유사 효과)
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
              icon: Icon(LucideIcons.home),
              label: '홈',
            ),
            const BottomNavigationBarItem(
              icon: Icon(LucideIcons.calendar),
              label: '캘린더',
            ),
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
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              label: '알림',
            ),
            const BottomNavigationBarItem(
              icon: Icon(LucideIcons.barChart2), // React의 TrendingUp 대체
              label: '기록',
            ),
          ],
        ),
      ),
    );
  }
}