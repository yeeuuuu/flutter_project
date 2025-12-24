import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project2/types/index.dart';
import 'package:flutter_project2/styles/theme.dart';
import 'package:uuid/uuid.dart';

class TaskDialog extends StatefulWidget {
  final Task? editingTask;
  final Function(Task) onSave;

  const TaskDialog({super.key, this.editingTask, required this.onSave});

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  late TextEditingController _titleController;
  late String _type;
  late DateTime _date;
  late String _color;

  final List<String> _colors = [
    '#EF4444',
    '#F59E0B',
    '#10B981',
    '#3B82F6',
    '#8B5CF6',
    '#EC4899'
  ];

  @override
  void initState() {
    super.initState();
    final task = widget.editingTask;
    _titleController = TextEditingController(text: task?.title ?? '');
    _type = task?.type ?? 'todo';
    _date = task != null ? DateTime.parse(task.date) : DateTime.now();
    _color = task?.color ?? _colors[0];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.editingTask != null ? '할 일 수정' : '새 할 일'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '제목',
                hintText: '할 일을 입력하세요',
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('할 일'),
                    value: 'todo',
                    groupValue: _type,
                    onChanged: (val) => setState(() => _type = val!),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('루틴'),
                    value: 'routine',
                    groupValue: _type,
                    onChanged: (val) => setState(() => _type = val!),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),

            const Text('날짜', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _date,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) setState(() => _date = picked);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.border),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Text(DateFormat('yyyy-MM-dd').format(_date)),
                    const Spacer(),
                    const Icon(Icons.calendar_today, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text('색상', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _colors.map((c) {
                final colorObj = Color(int.parse(c.replaceFirst('#', '0xFF')));
                final isSelected = _color == c;
                return GestureDetector(
                  onTap: () => setState(() => _color = c),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: colorObj,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.black, width: 2)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소',
              style: TextStyle(color: AppTheme.mutedForeground)),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.isEmpty) return;

            final newTask = Task(
              id: widget.editingTask?.id ?? const Uuid().v4(),
              title: _titleController.text,
              type: _type,
              completed: widget.editingTask?.completed ?? false,
              date: DateFormat('yyyy-MM-dd').format(_date),
              color: _color,
              createdAt: widget.editingTask?.createdAt ??
                  DateTime.now().toIso8601String(),
            );

            widget.onSave(newTask);
            Navigator.pop(context);
          },
          child: Text(widget.editingTask != null ? '수정' : '추가'),
        ),
      ],
    );
  }
}
