// lib/app.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_project2/styles/theme.dart';

// 탭 페이지 임시 import (나중에 실제 파일로 교체)
// import 'package:flutter_project2/components/home_tab.dart';
// import 'package:flutter_project2/components/calendar_tab.dart';
// import 'package:flutter_project2/components/records_tab.dart';
// import 'package:flutter_project2/components/notification_tab.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: AppTheme.lightTheme, // theme.dart 연결
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

  // 탭별 화면 정의
  final List<Widget> _screens = [
    const Center(child: Text("Home Tab")), // HomeTab()
    const Center(child: Text("Calendar Tab")), // CalendarTab()
    const Center(child: Text("Records Tab")), // RecordsTab()
    const Center(child: Text("Notifications")), // NotificationTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _screens,
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
          showSelectedLabels: false, // Shadcn 스타일처럼 깔끔하게
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.calendar),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.barChart2), // Records 아이콘
              label: 'Records',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.bell),
              label: 'Notifications',
            ),
          ],
        ),
      ),
    );
  }
}
