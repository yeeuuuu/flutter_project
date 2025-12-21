// import 'package:flutter/material.dart';
// import '../models/types.dart';
// import '../widgets/task_item.dart';

// class HomeTab extends StatefulWidget {
//   // 실제 앱에서는 상태 관리 라이브러리(Provider 등)를 쓰겠지만,
//   // 지금은 상위(Main)에서 데이터를 받아온다고 가정합니다.
//   final List<Task> tasks;
//   final Function(Task) onUpdateTask;
//   final Function(String) onDeleteTask;

//   const HomeTab({
//     super.key,
//     required this.tasks,
//     required this.onUpdateTask,
//     required this.onDeleteTask,
//   });

//   @override
//   State<HomeTab> createState() => _HomeTabState();
// }

// class _HomeTabState extends State<HomeTab> {
//   // 날짜 비교 헬퍼 함수
//   bool isSameDate(DateTime date1, DateTime date2) {
//     return date1.year == date2.year &&
//         date1.month == date2.month &&
//         date1.day == date2.day;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final now = DateTime.now();
//     final tomorrow = now.add(const Duration(days: 1));

//     // 오늘 할 일 필터링
//     final todayTasks = widget.tasks
//         .where((t) => isSameDate(t.date, now))
//         .toList();

//     // 내일 할 일 필터링
//     final tomorrowTasks = widget.tasks
//         .where((t) => isSameDate(t.date, tomorrow))
//         .toList();

//     return Scaffold(
//       backgroundColor: Colors.grey[50], // 배경색 살짝 회색
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           // --- 오늘 섹션 ---
//           _buildSectionHeader("오늘", Colors.black),
//           if (todayTasks.isEmpty)
//             _buildEmptyState("오늘 할 일이 없습니다")
//           else
//             ...todayTasks.map((task) => TaskItem(
//                   task: task,
//                   onToggle: (id) {
//                     // 완료 상태 토글 로직
//                     final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
//                     widget.onUpdateTask(updatedTask);
//                   },
//                   onEdit: (t) {
//                      // TODO: 다이얼로그 띄우기 연결 예정
//                      print("수정 클릭: ${t.title}");
//                   },
//                   onDelete: widget.onDeleteTask,
//                 )),

//           const SizedBox(height: 32), // 섹션 간 간격

//           // --- 내일 섹션 ---
//           _buildSectionHeader("내일", Colors.grey),
//           if (tomorrowTasks.isEmpty)
//             _buildEmptyState("내일 할 일이 없습니다")
//           else
//             ...tomorrowTasks.map((task) => TaskItem(
//                   task: task,
//                   onToggle: (id) {
//                     final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
//                     widget.onUpdateTask(updatedTask);
//                   },
//                   onEdit: (t) => print("수정 클릭"),
//                   onDelete: widget.onDeleteTask,
//                 )),
          
//           const SizedBox(height: 80), // 하단 탭바에 가려지지 않게 여유 공간
//         ],
//       ),
//     );
//   }

//   // 섹션 제목 위젯
//   Widget _buildSectionHeader(String title, Color dotColor) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12, left: 4),
//       child: Row(
//         children: [
//           Container(
//             width: 8,
//             height: 8,
//             decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
//           ),
//           const SizedBox(width: 8),
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black54,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // 빈 상태 메시지 위젯
//   Widget _buildEmptyState(String message) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 32),
//       alignment: Alignment.center,
//       child: Text(
//         message,
//         style: const TextStyle(color: Colors.grey),
//       ),
//     );
//   }
// }