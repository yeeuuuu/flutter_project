import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget child;
  final String? tooltip;

  const AppToggle({
    super.key,
    required this.value,
    required this.onChanged,
    required this.child,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = value ? AppTheme.muted : Colors.transparent; // on일 때 배경색
    final fgColor = value ? AppTheme.foreground : AppTheme.mutedForeground;

    Widget button = InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: IconTheme(
          data: IconThemeData(size: 20, color: fgColor),
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: fgColor,
            ),
            child: child,
          ),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip, child: button);
    }
    return button;
  }
}
