import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppTooltip extends StatelessWidget {
  final String message;
  final Widget child;

  const AppTooltip({super.key, required this.message, required this.child});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.foreground, // 툴팁 배경 (보통 반전색)
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: const TextStyle(
        color: AppTheme.background, // 툴팁 텍스트
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      preferBelow: false, // 위쪽에 표시 선호
      verticalOffset: 12,
      child: child,
    );
  }
}
