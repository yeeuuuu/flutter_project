import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget content,
    String? title,
    String? description,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, anim1, anim2) => const SizedBox(), // not used
      transitionBuilder: (context, anim1, anim2, child) {
        final curvedValue = Curves.easeInOut.transform(anim1.value);
        return Transform.translate(
          offset: Offset(
            MediaQuery.of(context).size.width * (1 - curvedValue),
            0,
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: AppTheme.background,
              elevation: 8,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85, // 화면의 85% 너비
                constraints: const BoxConstraints(maxWidth: 400),
                height: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Close Button & Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (title != null)
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (description != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  description,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.mutedForeground,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.x),
                          onPressed: () => Navigator.pop(context),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          color: AppTheme.mutedForeground,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Content
                    Expanded(child: SingleChildScrollView(child: content)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
