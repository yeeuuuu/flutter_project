import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppLabel extends StatelessWidget {
  final String text;
  final bool isError;
  final Widget? child; // Label과 연결된 입력 필드가 있는 경우

  const AppLabel({
    super.key,
    required this.text,
    this.isError = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isError ? AppTheme.destructive : AppTheme.foreground,
          ),
        ),
        if (child != null) ...[const SizedBox(height: 8), child!],
      ],
    );
  }
}
