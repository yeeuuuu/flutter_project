import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_project2/types/index.dart'; // Task 모델 import
import 'package:flutter_project2/styles/theme.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(String) onToggle;
  final Function(Task) onEdit;
  final Function(String) onDelete;
  final bool showDate;

  const TaskItem({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
    this.showDate = false,
  });

  @override
  Widget build(BuildContext context) {
    Color taskColor = _parseColor(task.color);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.background, 
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.1,
            child: Checkbox(
              value: task.completed,
              onChanged: (_) => onToggle(task.id),
              activeColor: AppTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 16,
                    decoration:
                        task.completed ? TextDecoration.lineThrough : null,
                    color: task.completed
                        ? AppTheme.mutedForeground
                        : AppTheme.foreground,
                  ),
                ),
                if (showDate) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      border: Border.all(color: taskColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      task.type == 'routine' ? '루틴' : '할 일',
                      style: TextStyle(fontSize: 10, color: taskColor),
                    ),
                  )
                ]
              ],
            ),
          ),

          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: taskColor,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(LucideIcons.pencil, size: 16),
            onPressed: () => onEdit(task),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            color: AppTheme.mutedForeground,
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(LucideIcons.trash2, size: 16),
            onPressed: () => onDelete(task.id),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            color: AppTheme.destructive,
          ),
        ],
      ),
    );
  }

  Color _parseColor(String hexString) {
    try {
      return Color(int.parse(hexString.replaceFirst('#', '0xFF')));
    } catch (e) {
      return Colors.grey;
    }
  }
}
