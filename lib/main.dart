import 'package:flutter/material.dart';
import 'screens/home_tab.dart';
import 'models/types.dart';
// import 'screens/home_tab.dart'; // 나중에 실제 파일 만들면 주석 해제
// import 'screens/calendar_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      theme: ThemeData(
        // globals.css의 색상 테마를 여기에 적용 (예시: 보라색)
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[50], // 배경색
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // React의 useState 역할: 현재 선택된 탭 인덱스 저장
  int _selectedIndex = 0;

  

  // 탭별 화면 리스트 (아직 파일이 없으므로 임시 Placeholder 위젯 사용)
  static final List<Widget> _widgetOptions = <Widget>[
    const Center(child: Text('홈 화면 (HomeTab)')), // Index 0
    const Center(child: Text('캘린더 (CalendarTab)')), // Index 1
    const Center(child: Text('기록 (RecordsTab)')), // Index 2
    const Center(child: Text('알림 (NotificationsTab)')), // Index 3
  ];

  // 탭을 눌렀을 때 실행되는 함수
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 앱바 (필요 없다면 제거 가능)
      appBar: AppBar(
        title: const Text('My Tasks'),
        centerTitle: false,
        elevation: 0,
      ),

      // 현재 선택된 탭의 화면을 보여줌
      body: _widgetOptions.elementAt(_selectedIndex),

      // 하단 네비게이션 바 (App.tsx의 하단 메뉴 역할)
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '일정',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '기록'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: '알림'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple, // 활성화된 탭 색상
        unselectedItemColor: Colors.grey, // 비활성화된 탭 색상
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // 탭이 4개 이상일 때 필수
      ),

      // 우측 하단 플로팅 버튼 (작업 추가용)
      floatingActionButton:
          _selectedIndex ==
              0 // 홈 탭에서만 보이게 설정
          ? FloatingActionButton(
              onPressed: () {
                // TODO: TaskDialog 띄우기
                print('할 일 추가 버튼 클릭됨');
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
