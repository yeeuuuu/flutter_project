import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CustomLabel extends StatelessWidget {
  final String text;
  final bool required;

  const CustomLabel(this.text, {super.key, this.required = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.foreground,
            ),
          ),
          if (required)
            const Text(" *", style: TextStyle(color: AppTheme.destructive)),
        ],
      ),
    );
  }
}