import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project2/types/index.dart';
import 'package:flutter_project2/components/task_item.dart';
import 'package:flutter_project2/components/task_dialog.dart';
import 'package:flutter_project2/styles/theme.dart';


class HomeTab extends StatefulWidget {
  final List<Task> tasks;
  final Function(Task) onUpdateTask;
  final Function(String) onDeleteTask;

  const HomeTab({
    super.key,
    required this.tasks,
    required this.onUpdateTask,
    required this.onDeleteTask,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  void _openTaskDialog([Task? task]) {
    showDialog(
      context: context,
      builder: (context) => TaskDialog(
        editingTask: task,
        onSave: widget.onUpdateTask,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final todayStr = DateFormat('yyyy-MM-dd').format(now);
    final tomorrowStr =
        DateFormat('yyyy-MM-dd').format(now.add(const Duration(days: 1)));

    final todayTasks = widget.tasks.where((t) => t.date == todayStr).toList();
    final tomorrowTasks =
        widget.tasks.where((t) => t.date == tomorrowStr).toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTaskDialog(),
        backgroundColor: AppTheme.primary,
        child: const Icon(LucideIcons.plus, color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader(
              "오늘",
              Colors
                  .transparent),
          if (todayTasks.isEmpty)
            _buildEmptyState("오늘 할 일이 없습니다")
          else
            ...todayTasks.map((task) => TaskItem(
                  task: task,
                  onToggle: (id) {
                    final updated = task.copyWith(completed: !task.completed);
                    widget.onUpdateTask(updated);
                  },
                  onEdit: _openTaskDialog,
                  onDelete: widget.onDeleteTask,
                )),

          const SizedBox(height: 24),

          _buildSectionHeader("내일", AppTheme.primary),
          if (tomorrowTasks.isEmpty)
            _buildEmptyState("내일 할 일이 없습니다")
          else
            ...tomorrowTasks.map((task) => TaskItem(
                  task: task,
                  onToggle: (id) {
                    final updated = task.copyWith(completed: !task.completed);
                    widget.onUpdateTask(updated);
                  },
                  onEdit: _openTaskDialog,
                  onDelete: widget.onDeleteTask,
                )),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color dotColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          if (dotColor != Colors.transparent) ...[
            Container(
                width: 8,
                height: 8,
                decoration:
                    BoxDecoration(color: dotColor, shape: BoxShape.circle)),
            const SizedBox(width: 8),
          ],
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.mutedForeground)),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child:
            Text(text, style: const TextStyle(color: AppTheme.mutedForeground)),
      ),
    );
  }
}
