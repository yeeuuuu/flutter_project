import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppDialog {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? description,
    required Widget content,
    List<Widget>? actions,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.background,
        surfaceTintColor: Colors.transparent, // Material 3 틴트 제거
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        actionsPadding: const EdgeInsets.all(24),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            if (description != null) ...[
              const SizedBox(height: 6),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.mutedForeground,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ],
        ),
        content: SingleChildScrollView(child: content),
        actions: actions,
      ),
    );
  }
}
