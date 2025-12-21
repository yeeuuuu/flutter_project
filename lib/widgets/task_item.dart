import 'package:flutter/material.dart';
import '../models/types.dart'; // 앞서 만든 Task 모델 import

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(String id) onToggle;
  final Function(Task task) onEdit;
  final Function(String id) onDelete;

  const TaskItem({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  // 색상 문자열(#RRGGBB)을 Flutter Color 객체로 변환하는 헬퍼 함수
  Color _hexToColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      return Color(int.parse('FF$hexColor', radix: 16));
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final taskColor = _hexToColor(task.color); // Task 모델에 color 필드가 String이라고 가정

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      elevation: 0, // React 디자인이 플랫해서 그림자 제거
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // 1. 체크박스
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: task.isCompleted,
                activeColor: taskColor,
                onChanged: (_) => onToggle(task.id),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // 2. 내용 (제목 + 뱃지)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task.isCompleted ? Colors.grey : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // 뱃지 (Routine / Todo)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      border: Border.all(color: taskColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      task.priority == Priority.high ? '중요' : '할 일', // 예시 로직
                      style: TextStyle(
                        color: taskColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 3. 색상 점 (원형)
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: taskColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),

            // 4. 수정/삭제 버튼 (PopupMenu로 심플하게 구현)
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') onEdit(task);
                if (value == 'delete') onDelete(task.id);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: Row(
                    children: [Icon(Icons.edit, size: 16), SizedBox(width: 8), Text('수정')],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [Icon(Icons.delete, size: 16, color: Colors.red), SizedBox(width: 8), Text('삭제')],
                  ),
                ),
              ],
              icon: const Icon(Icons.more_vert, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}