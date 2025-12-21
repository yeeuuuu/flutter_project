import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/common/custom_button.dart'; // 테스트용
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // 우리가 만든 테마 적용
      home: const MainScreen(),
    );
  }
}

// 탭 네비게이션을 위한 메인 스크린 (App.tsx의 레이아웃 역할)
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // // 나중에 screens 폴더의 화면들로 교체할 부분입니다.
  // final List<Widget> _screens = [
  //   const Center(child: Text("Home Screen Placeholder")), // HomeTab
  //   const Center(child: Text("Calendar Screen Placeholder")), // CalendarTab
  //   const Center(child: Text("Records Screen Placeholder")), // RecordsTab
  //   const Center(
  //     child: Text("Notifications Screen Placeholder"),
  //   ), // NotificationsTab
  // ];

  final List<Widget> _screens = [
    const HomeScreen(), // <-- 여기를 Placeholder에서 실제 위젯으로 교체
    const Center(child: Text("Calendar Screen Placeholder")),
    const Center(child: Text("Records Screen Placeholder")),
    const Center(child: Text("Notifications Screen Placeholder")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _screens[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: AppTheme.mutedForeground,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Records',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}
