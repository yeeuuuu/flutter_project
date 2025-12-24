import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_project2/types/index.dart';
import 'package:flutter_project2/styles/theme.dart';

class CalendarTab extends StatefulWidget {
  final List<Task> tasks;

  const CalendarTab({super.key, required this.tasks});

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  DateTime _selectedDate = DateTime.now(); // 사용자가 클릭한 날짜
  DateTime _focusedDate = DateTime.now(); // 현재 보고 있는 달력의 월

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. 커스텀 캘린더 헤더 (월 이동)
        _buildHeader(),

        // 2. 요일 헤더 (일 월 화 수 목 금 토)
        _buildDaysOfWeek(),

        // 3. 캘린더 그리드 (날짜 + 점 표시)
        _buildCalendarGrid(),

        const Divider(height: 1, color: AppTheme.border),

        // 4. 선택된 날짜의 할 일 목록
        Expanded(
          child: _buildTaskList(),
        ),
      ],
    );
  }

  // --- 위젯 빌더 메서드들 ---

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(LucideIcons.chevronLeft),
            onPressed: () {
              setState(() {
                _focusedDate =
                    DateTime(_focusedDate.year, _focusedDate.month - 1);
              });
            },
          ),
          Text(
            DateFormat('yyyy년 MM월').format(_focusedDate),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(LucideIcons.chevronRight),
            onPressed: () {
              setState(() {
                _focusedDate =
                    DateTime(_focusedDate.year, _focusedDate.month + 1);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDaysOfWeek() {
    final days = ['일', '월', '화', '수', '목', '금', '토'];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days
            .map((day) => Text(
                  day,
                  style: const TextStyle(
                    color: AppTheme.mutedForeground,
                    fontWeight: FontWeight.w500,
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth =
        DateTime(_focusedDate.year, _focusedDate.month + 1, 0).day;
    final firstDayOfMonth = DateTime(_focusedDate.year, _focusedDate.month, 1);

    // 1일의 요일 (1: 월요일, ..., 7: 일요일).
    // 일요일(7)을 0으로, 월요일(1)을 1로 만들기 위해 % 7 사용
    final weekdayOffset = firstDayOfMonth.weekday % 7;

    return GridView.builder(
      shrinkWrap: true, // 내부 스크롤 방지
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // 7일
        childAspectRatio: 1.2, // 셀 비율 (높이 조절)
      ),
      itemCount: daysInMonth + weekdayOffset,
      itemBuilder: (context, index) {
        if (index < weekdayOffset) {
          return const SizedBox.shrink(); // 날짜 없는 빈 칸
        }

        final day = index - weekdayOffset + 1;
        final currentDate =
            DateTime(_focusedDate.year, _focusedDate.month, day);
        final currentDateStr = DateFormat('yyyy-MM-dd').format(currentDate);

        // 해당 날짜에 일정이 있는지 확인
        final hasTasks = widget.tasks.any((t) => t.date == currentDateStr);
        // 완료되지 않은 일정이 있는지 (점 색상 구분용, 선택사항)
        final hasIncomplete =
            widget.tasks.any((t) => t.date == currentDateStr && !t.completed);

        final isSelected = isSameDay(currentDate, _selectedDate);
        final isToday = isSameDay(currentDate, DateTime.now());

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = currentDate;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 날짜 원형 배경
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primary
                      : (isToday ? AppTheme.primary.withOpacity(0.1) : null),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$day',
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : (isToday ? AppTheme.primary : Colors.black),
                    fontWeight: isSelected || isToday
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // 점 표시 (Dot)
              if (hasTasks)
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: hasIncomplete ? AppTheme.destructive : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                )
              else
                const SizedBox(height: 5), // 공간 유지용
            ],
          ),
        );
      },
    );
  }

  Widget _buildTaskList() {
    final selectedDateStr = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final tasksForDate =
        widget.tasks.where((t) => t.date == selectedDateStr).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          "${DateFormat('M월 d일').format(_selectedDate)} 일정",
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.mutedForeground),
        ),
        const SizedBox(height: 12),
        if (tasksForDate.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                "등록된 일정이 없습니다.",
                style: TextStyle(color: AppTheme.mutedForeground),
              ),
            ),
          )
        else
          ...tasksForDate.map((task) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppTheme.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(
                            int.parse(task.color.replaceFirst('#', '0xFF'))),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 14,
                              decoration: task.completed
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: task.completed
                                  ? AppTheme.mutedForeground
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            task.type == 'routine' ? '루틴' : '할 일',
                            style: const TextStyle(
                                fontSize: 10, color: AppTheme.mutedForeground),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
      ],
    );
  }

  // 날짜 비교 헬퍼 함수
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
