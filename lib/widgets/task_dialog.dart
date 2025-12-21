import 'package:flutter/material.dart';
import '../models/types.dart'; // Task 모델 import

class TaskDialog extends StatefulWidget {
  final Task? initialTask; // 수정일 경우 기존 데이터, 추가일 경우 null
  final Function(Task) onSave; // 저장 버튼 눌렀을 때 실행될 함수

  const TaskDialog({
    super.key,
    this.initialTask,
    required this.onSave,
  });

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  // 폼 입력값 관리를 위한 컨트롤러와 변수들
  late TextEditingController _titleController;
  late DateTime _selectedDate;
  late TaskType _selectedType; // 'todo' or 'routine' (enum 필요)
  late String _selectedColor;

  // React 코드에 있던 색상 목록
  final List<String> _colors = [
    '#EF4444', // Red
    '#F59E0B', // Amber
    '#10B981', // Green
    '#3B82F6', // Blue
    '#8B5CF6', // Violet
    '#EC4899', // Pink
  ];

  @override
  void initState() {
    super.initState();
    // 초기값 설정 (수정 모드 vs 추가 모드)
    final task = widget.initialTask;
    _titleController = TextEditingController(text: task?.title ?? '');
    _selectedDate = task?.date ?? DateTime.now();
    
    // TaskType이 Enum으로 정의되어 있다고 가정 (없다면 String으로 처리 가능)
    // 여기서는 편의상 String 비교 로직을 넣거나, 아래 로직을 사용합니다.
    _selectedType = (task?.type == 'routine') ? TaskType.routine : TaskType.todo;
    
    _selectedColor = task?.color ?? _colors[0]; // 기본값 빨강
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  // 색상 문자열을 Color 객체로 변환
  Color _hexToColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      return Color(int.parse('FF$hexColor', radix: 16));
    }
    return Colors.grey;
  }

  // 저장 처리
  void _handleSave() {
    if (_titleController.text.trim().isEmpty) return;

    final newTask = Task(
      id: widget.initialTask?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      description: '',
      date: _selectedDate,
      isCompleted: widget.initialTask?.isCompleted ?? false,
      priority: Priority.medium, // 기본값
      type: _selectedType.name, // Task 모델에 type 필드가 String이라면 .name 사용
      color: _selectedColor,
    );

    widget.onSave(newTask);
    Navigator.of(context).pop(); // 다이얼로그 닫기
  }

  // 날짜 선택기 띄우기
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 내용물만큼만 높이 차지
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 헤더
            Text(
              widget.initialTask == null ? '할 일 추가' : '할 일 수정',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // 2. 제목 입력
            const Text('제목', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: '무엇을 해야 하나요?',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
            const SizedBox(height: 16),

            // 3. 타입 선택 (할 일 / 루틴) - React의 RadioGroup 대체
            const Text('종류', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildTypeOption('할 일', TaskType.todo),
                const SizedBox(width: 12),
                _buildTypeOption('루틴', TaskType.routine),
              ],
            ),
            const SizedBox(height: 16),

            // 4. 날짜 선택
            const Text('날짜', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            InkWell(
              onTap: _pickDate,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 5. 색상 선택
            const Text('색상', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _colors.map((color) {
                final isSelected = _selectedColor == color;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = color),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _hexToColor(color),
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.black, width: 2)
                          : null,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 20)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // 6. 하단 버튼 (취소 / 저장)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('취소', style: TextStyle(color: Colors.grey)),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(widget.initialTask == null ? '추가' : '수정'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 타입 선택 버튼 빌더 위젯
  Widget _buildTypeOption(String label, TaskType value) {
    final isSelected = _selectedType == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedType = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            border: Border.all(color: isSelected ? Colors.black : Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// types.dart에 아직 Enum이 없다면 아래 코드를 types.dart에 추가해야 합니다.
enum TaskType { todo, routine }