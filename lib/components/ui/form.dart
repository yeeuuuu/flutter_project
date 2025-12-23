import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppFormItem extends StatelessWidget {
  final String label;
  final Widget child;
  final String? errorText;
  final String? description;

  const AppFormItem({
    super.key,
    required this.label,
    required this.child,
    this.errorText,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color:
                errorText != null ? AppTheme.destructive : AppTheme.foreground,
          ),
        ),
        const SizedBox(height: 8),

        // Input Control
        child,

        // Description or Error
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              errorText!,
              style: const TextStyle(fontSize: 12, color: AppTheme.destructive),
            ),
          )
        else if (description != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              description!,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.mutedForeground,
              ),
            ),
          ),
      ],
    );
  }
}
