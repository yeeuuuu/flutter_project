import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppProgress extends StatelessWidget {
  final double value; // 0.0 to 1.0 (Shadcn은 0~100이지만 Flutter는 0~1)
  final double height;

  const AppProgress({super.key, required this.value, this.height = 8.0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9999), // full rounded
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: AppTheme.muted, // secondary color
        color: AppTheme.primary,
        minHeight: height,
      ),
    );
  }
}
