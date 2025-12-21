import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/types.dart';
import '../../theme/app_theme.dart';
import '../common/custom_button.dart';
import '../common/custom_input.dart';
import '../common/custom_label.dart';

class TaskDialog extends StatefulWidget {
  final Task? editingTask; // 수정 모드일 경우 데이터 전달
  final Function(Task) onSave; // 저장 버튼 콜백

  const TaskDialog({super.key, this.editingTask, required this.onSave});

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  late TextEditingController _titleController;
  Category _selectedCategory = Category.work;
  Priority _selectedPriority = Priority.medium; // 기본값
  late DateTime _selectedDate;

  // React 코드의 colors 배열
  final List<Color> _colors = [
    const Color(0xFFEF4444), // red
    const Color(0xFFF59E0B), // amber
    const Color(0xFF10B981), // green
    const Color(0xFF3B82F6), // blue
    const Color(0xFF8B5CF6), // violet
    const Color(0xFFEC4899), // pink
  ];
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    final task = widget.editingTask;
    _titleController = TextEditingController(text: task?.title ?? '');
    _selectedCategory = task?.category ?? Category.work;
    _selectedPriority = task?.priority ?? Priority.medium;
    _selectedDate = task?.date ?? DateTime.now();
    // 기존 task에 색상 필드가 없어서 임의 로직 혹은 모델에 색상 추가 필요
    // 여기서는 첫 번째 색상을 기본값으로 사용
    _selectedColor = _colors[0];
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_titleController.text.isEmpty) return;

    final newTask = Task(
      id:
          widget.editingTask?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      date: _selectedDate,
      category: _selectedCategory,
      priority: _selectedPriority,
      completed: widget.editingTask?.completed ?? false,
      // color: _selectedColor, // Task 모델에 color 필드가 있다면 추가
    );

    widget.onSave(newTask);
    Navigator.of(context).pop(); // 다이얼로그 닫기
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: AppTheme.lightTheme.copyWith(
            colorScheme: AppTheme.lightTheme.colorScheme.copyWith(
              primary: AppTheme.primary, // 달력 헤더 색상
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Text(
              widget.editingTask != null ? "할 일 수정" : "할 일 추가",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            const Text(
              "새로운 할 일을 목록에 추가합니다.",
              style: TextStyle(fontSize: 14, color: AppTheme.mutedForeground),
            ),
            const SizedBox(height: 24),

            // Form Fields
            // 1. Title
            const CustomLabel("제목"),
            CustomInput(
              controller: _titleController,
              placeholder: "할 일을 입력하세요",
            ),
            const SizedBox(height: 16),

            // 2. Category (Radio Group mimic)
            const CustomLabel("카테고리"),
            Row(
              children: [
                _buildRadioItem("할 일 (Work)", Category.work),
                const SizedBox(width: 12),
                _buildRadioItem("루틴 (Personal)", Category.personal),
              ],
            ),
            const SizedBox(height: 16),

            // 3. Date Picker
            const CustomLabel("날짜"),
            InkWell(
              onTap: _pickDate,
              borderRadius: BorderRadius.circular(AppTheme.radius),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.border),
                  borderRadius: BorderRadius.circular(AppTheme.radius),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppTheme.mutedForeground,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('yyyy-MM-dd').format(_selectedDate),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 4. Color Picker
            const CustomLabel("색상"),
            Wrap(
              spacing: 8,
              children: _colors.map((color) {
                final isSelected = _selectedColor == color;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = color),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: AppTheme.primary, width: 2)
                          : null,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Footer Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  label: "취소",
                  variant: ButtonVariant.outline,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 8),
                CustomButton(
                  label: widget.editingTask != null ? "수정" : "추가",
                  onPressed: _handleSave,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioItem(String label, Category value) {
    final isSelected = _selectedCategory == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = value),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected ? AppTheme.primary : AppTheme.mutedForeground,
            size: 20,
          ),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
