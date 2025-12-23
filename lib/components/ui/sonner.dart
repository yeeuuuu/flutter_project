import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppToast {
  static void show(
    BuildContext context,
    String message, {
    String? description,
    bool isError = false,
    VoidCallback? onUndo,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isError ? Colors.white : AppTheme.foreground,
              ),
            ),
            if (description != null)
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: isError ? Colors.white70 : AppTheme.mutedForeground,
                ),
              ),
          ],
        ),
        backgroundColor: isError ? AppTheme.destructive : AppTheme.background,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: isError
              ? BorderSide.none
              : const BorderSide(color: AppTheme.border),
        ),
        action: onUndo != null
            ? SnackBarAction(
                label: '실행 취소',
                textColor: isError ? Colors.white : AppTheme.primary,
                onPressed: onUndo,
              )
            : null,
        elevation: 4,
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
